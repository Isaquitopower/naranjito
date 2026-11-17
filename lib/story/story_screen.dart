import 'dart:async';
import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'soundtrack_service.dart';
import 'story_data.dart';
import 'story_flame_game.dart';
import 'voice_narrator_service.dart';

class StoryReaderScreen extends StatefulWidget {
  final int storyIndex;

  const StoryReaderScreen({
    super.key,
    this.storyIndex = 0,
  });

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen>
    with TickerProviderStateMixin {
  int _sceneIndex = 0;
  int _beatIndex = 0;
  int _charOffset = 0;
  bool _isPaused = false;
  bool _isWaitingAudioCompleter = false;
  bool _didSeekWhilePaused = false;
  bool _narrationCompletedForScene = false;
  int _playbackSessionId = 0;
  Timer? _autoAdvanceTimer;
  Completer<void>? _activeBeatCompleter;
  final ValueNotifier<double> _progressNotifier = ValueNotifier<double>(0.0);

  void _resolvePendingBeatCompleter() {
    _isWaitingAudioCompleter = false;
    final completer = _activeBeatCompleter;
    _activeBeatCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
  }

  late final StoryFlameGame _game;
  late final AnimationController _pulseController;

  List<StorySceneData> get _scenes => getStoryScenes(widget.storyIndex);

  int get _totalCharsInStory {
    var chars = 0;
    for (final s in _scenes) {
      for (final b in s.beats) {
        chars += b.text.length;
      }
    }
    return chars > 0 ? chars : 1;
  }

  int get _currentGlobalCharsSpoken {
    var chars = 0;
    for (var i = 0; i < _sceneIndex; i++) {
      for (final b in _scenes[i].beats) {
        chars += b.text.length;
      }
    }
    final currentScene = _scenes[_sceneIndex];
    for (var b = 0; b < _beatIndex && b < currentScene.beats.length; b++) {
      chars += currentScene.beats[b].text.length;
    }
    chars += _charOffset;
    return chars;
  }

  double get _currentGlobalProgress {
    final total = _totalCharsInStory;
    final current = _currentGlobalCharsSpoken;
    return (current / total).clamp(0.0, 1.0);
  }

  void _seekToGlobalProgress(double progress) {
    final targetChars = (progress * _totalCharsInStory).round();
    var accumulated = 0;

    for (var sIdx = 0; sIdx < _scenes.length; sIdx++) {
      final scene = _scenes[sIdx];
      for (var bIdx = 0; bIdx < scene.beats.length; bIdx++) {
        final beatLen = scene.beats[bIdx].text.length;
        if (targetChars <= accumulated + beatLen) {
          final offsetInBeat = (targetChars - accumulated).clamp(0, beatLen);
          _seekToSceneBeatAndChar(sIdx, bIdx, offsetInBeat);
          return;
        }
        accumulated += beatLen;
      }
    }
    _seekToSceneBeatAndChar(_scenes.length - 1, _scenes.last.beats.length - 1, 0);
  }

  Future<void> _seekToSceneBeatAndChar(
    int sceneIdx,
    int beatIdx,
    int charOffset,
  ) async {
    _resolvePendingBeatCompleter();
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    await VoiceNarratorService.instance.stop();

    if (!mounted) return;
    setState(() {
      _sceneIndex = sceneIdx;
      _beatIndex = beatIdx;
      _charOffset = charOffset;
      _narrationCompletedForScene = false;
      if (_isPaused) {
        _didSeekWhilePaused = true;
      }
    });
    _progressNotifier.value = _currentGlobalProgress;

    await _game.loadScene(sceneIdx);
    if (!mounted) return;

    if (_isPaused) {
      // Just apply pose of that beat without speaking while paused
      final scene = _scenes[sceneIdx];
      if (beatIdx < scene.beats.length) {
        _game.applyVoiceBeat(scene.beats[beatIdx]);
      }
    } else {
      _playCurrentSceneScript(
        fromBeatIndex: beatIdx,
        fromCharOffset: charOffset,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _game = StoryFlameGame(
      storyIndex: widget.storyIndex,
      onSceneReady: () {
        if (mounted) {
          _playCurrentSceneScript();
        }
      },
      onSpeakRequest: (phrase, pitch, speakerId) {
        _speakSingleInteraction(phrase, pitch: pitch, speakerId: speakerId);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SoundtrackService.instance.playStoryMusic(widget.storyIndex);
      VoiceNarratorService.instance.onSpeechProgress = (offset) {
        if (mounted && !_isPaused) {
          _charOffset = offset;
          _progressNotifier.value = _currentGlobalProgress;
        }
      };
    });
  }

  @override
  void dispose() {
    VoiceNarratorService.instance.onSpeechProgress = null;
    _progressNotifier.dispose();
    _resolvePendingBeatCompleter();
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    _pulseController.dispose();
    if (_isPaused) {
      unawaited(SoundtrackService.instance.resumeMusic());
    }
    VoiceNarratorService.instance.stop();
    super.dispose();
  }

  void _completeCurrentScene(int sessionId) {
    if (!mounted || sessionId != _playbackSessionId || _isPaused) return;
    final isLastScene = _sceneIndex >= _scenes.length - 1;
    setState(() {
      _charOffset = 0;
      _narrationCompletedForScene = true;
    });
    if (isLastScene) {
      _progressNotifier.value = 1.0;
    }
    _game.setActiveSpeaker(null);

    final delay = isLastScene
        ? const Duration(milliseconds: 450)
        : const Duration(milliseconds: 1400);
    _autoAdvanceTimer = Timer(delay, () {
      if (!mounted || sessionId != _playbackSessionId || _isPaused) return;
      if (!isLastScene) {
        _goToScene(_sceneIndex + 1);
      } else {
        _showVisualCelebrationModal();
      }
    });
  }

  void _togglePause() {
    if (_isPaused) {
      // Resume both narration and music cleanly
      setState(() {
        _isPaused = false;
      });
      unawaited(SoundtrackService.instance.resumeMusic());

      if (_didSeekWhilePaused) {
        _didSeekWhilePaused = false;
        _playCurrentSceneScript(
          fromBeatIndex: _beatIndex,
          fromCharOffset: _charOffset,
        );
      } else if (_narrationCompletedForScene) {
        final sessionId = _playbackSessionId;
        final isLastScene = _sceneIndex >= _scenes.length - 1;
        _autoAdvanceTimer = Timer(
          isLastScene
              ? const Duration(milliseconds: 450)
              : const Duration(milliseconds: 1400),
          () {
            if (!mounted || sessionId != _playbackSessionId || _isPaused) return;
            if (!isLastScene) {
              _goToScene(_sceneIndex + 1);
            } else {
              _showVisualCelebrationModal();
            }
          },
        );
      } else if (_isWaitingAudioCompleter) {
        final beats = _scenes[_sceneIndex].beats;
        if (_beatIndex < beats.length) {
          _game.setActiveSpeaker(beats[_beatIndex].speakerId);
        }
        unawaited(VoiceNarratorService.instance.resume());
      } else {
        // Paused during inter-beat gap: resume from the next beat or complete scene
        final nextBeat = _beatIndex + 1;
        if (nextBeat < _scenes[_sceneIndex].beats.length) {
          _playCurrentSceneScript(fromBeatIndex: nextBeat, fromCharOffset: 0);
        } else {
          _completeCurrentScene(_playbackSessionId);
        }
      }
    } else {
      // Pause both narration (exact millisecond) and background music
      if (!_isWaitingAudioCompleter) {
        _playbackSessionId++;
      }
      _autoAdvanceTimer?.cancel();
      unawaited(VoiceNarratorService.instance.pause());
      unawaited(SoundtrackService.instance.pauseMusic());
      setState(() {
        _isPaused = true;
        _didSeekWhilePaused = false;
      });
      _game.setActiveSpeaker(null);
    }
  }

  Future<void> _playCurrentSceneScript({
    int fromBeatIndex = 0,
    int fromCharOffset = 0,
  }) async {
    _autoAdvanceTimer?.cancel();
    _resolvePendingBeatCompleter();
    final sessionId = ++_playbackSessionId;
    await VoiceNarratorService.instance.stop();

    if (!mounted || _isPaused || sessionId != _playbackSessionId) return;
    final scene = _scenes[_sceneIndex];

    setState(() {
      _beatIndex = fromBeatIndex;
      _charOffset = fromCharOffset;
      _narrationCompletedForScene = false;
    });
    _progressNotifier.value = _currentGlobalProgress;

    for (var i = fromBeatIndex; i < scene.beats.length; i++) {
      if (!mounted || sessionId != _playbackSessionId || _isPaused) return;
      _beatIndex = i;
      _progressNotifier.value = _currentGlobalProgress;
      final beat = scene.beats[i];

      // Update each character's exact pose and position for this beat
      _game.applyVoiceBeat(beat);

      final startOffset = (i == fromBeatIndex) ? fromCharOffset : 0;
      _charOffset = startOffset;

      final completer = Completer<void>();
      _activeBeatCompleter = completer;
      _isWaitingAudioCompleter = true;
      await VoiceNarratorService.instance.speak(
        beat.text,
        pitch: beat.pitch,
        rate: beat.rate,
        startCharOffset: startOffset,
        onDone: () {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      );

      await completer.future;
      if (identical(_activeBeatCompleter, completer)) {
        _activeBeatCompleter = null;
      }
      _isWaitingAudioCompleter = false;
      if (!mounted || sessionId != _playbackSessionId || _isPaused) return;

      // Completed this beat normally, reset offset for next beats
      _charOffset = 0;

      // Natural pause between story beats
      await Future<void>.delayed(const Duration(milliseconds: 350));
    }

    _completeCurrentScene(sessionId);
  }

  Future<void> _speakSingleInteraction(
    String phrase, {
    double pitch = 1.2,
    String speakerId = 'narrador',
  }) async {
    _autoAdvanceTimer?.cancel();
    _resolvePendingBeatCompleter();
    final sessionId = ++_playbackSessionId;
    await VoiceNarratorService.instance.stop();

    if (!mounted) return;
    setState(() {
      _isPaused = false;
      _didSeekWhilePaused = false;
    });
    unawaited(SoundtrackService.instance.resumeMusic());
    _game.setActiveSpeaker(speakerId);

    await VoiceNarratorService.instance.speak(
      phrase,
      pitch: pitch,
      rate: 0.46,
      onDone: () {
        if (!mounted || sessionId != _playbackSessionId) return;
        setState(() {
          _narrationCompletedForScene = true;
        });
        _game.setActiveSpeaker(null);
      },
    );
  }

  Future<void> _goToScene(int newIndex) async {
    if (newIndex < 0 || newIndex >= _scenes.length) return;
    _resolvePendingBeatCompleter();
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    await VoiceNarratorService.instance.stop();
    if (!mounted) return;

    setState(() {
      _sceneIndex = newIndex;
      _beatIndex = 0;
      _charOffset = 0;
      _isPaused = false;
      _didSeekWhilePaused = false;
      _narrationCompletedForScene = false;
    });
    _progressNotifier.value = _currentGlobalProgress;
    unawaited(SoundtrackService.instance.resumeMusic());
    await _game.loadScene(newIndex);
    if (!mounted) return;
    _playCurrentSceneScript();
  }

  void _showVisualCelebrationModal() {
    _resolvePendingBeatCompleter();
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    _game.setActiveSpeaker(null);
    _game.triggerAllCharactersDance();

    final completionVoice = getStoryCompletionVoice(widget.storyIndex);

    VoiceNarratorService.instance.speak(
      completionVoice,
      pitch: 1.22,
      rate: 0.46,
    );

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return _CelebrationAnimatedDialog(
          storyIndex: widget.storyIndex,
          onReplay: () {
            Navigator.of(ctx).pop();
            _goToScene(0);
          },
          onHome: () {
            if (_isPaused) {
              unawaited(SoundtrackService.instance.resumeMusic());
            }
            VoiceNarratorService.instance.stop();
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 0. Instant background layer visible on the very first frame
          Positioned.fill(
            child: Image.asset(
              'assets/images/${_scenes[_sceneIndex].backgroundAsset}',
              fit: BoxFit.fill,
              gaplessPlayback: true,
            ),
          ),

          // 1. Fullscreen Flame Interactive World (100% visual, zero text)
          Positioned.fill(
            child: GameWidget(game: _game),
          ),

          // 2. Top-Left Home Button & Visual Progress Hearts (No letters or numbers)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundKidsButton(
                    icon: Icons.home_rounded,
                    color: const Color(0xFFFF7043),
                    size: 62,
                    onTap: () {
                      _resolvePendingBeatCompleter();
                      _playbackSessionId++;
                      if (_isPaused) {
                        unawaited(SoundtrackService.instance.resumeMusic());
                      }
                      VoiceNarratorService.instance.stop();
                      Navigator.of(context).pop();
                    },
                  ),

                  // 2. Interactive faithful progress bar (Kids-friendly, scrubbable slider)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFFFFB74D),
                            width: 3.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.auto_stories_rounded,
                              color: Color(0xFFFF8F00),
                              size: 26,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ValueListenableBuilder<double>(
                                valueListenable: _progressNotifier,
                                builder: (context, progressVal, _) {
                                  return SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 12,
                                      activeTrackColor: const Color(0xFFFF8F00),
                                      inactiveTrackColor: const Color(0xFFFFE0B2),
                                      thumbColor: const Color(0xFFFF6D00),
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 14,
                                        elevation: 4,
                                      ),
                                      overlayColor: const Color(0xFFFF8F00)
                                          .withValues(alpha: 0.22),
                                      overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 22,
                                      ),
                                    ),
                                    child: Slider(
                                      value: progressVal.clamp(0.0, 1.0),
                                      min: 0.0,
                                      max: 1.0,
                                      onChanged: (val) {
                                        _progressNotifier.value = val;
                                        _seekToGlobalProgress(val);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFB300),
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  _RoundKidsButton(
                    icon: Icons.settings_rounded,
                    color: const Color(0xFF8E24AA),
                    size: 56,
                    onTap: () => showAppSettingsDialog(context),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom-Right Pause / Play Button
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              top: false,
              left: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 24, 20),
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = _isPaused
                        ? 1.0 + (_pulseController.value * 0.12)
                        : 1.0;
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: _RoundKidsButton(
                    icon: _isPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    color: _isPaused
                        ? const Color(0xFF43A047)
                        : const Color(0xFFFF9800),
                    size: 72,
                    onTap: _togglePause,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundKidsButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double size;

  const _RoundKidsButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.56,
          ),
        ),
      ),
    );
  }
}

class _CelebrationAnimatedDialog extends StatefulWidget {
  final int storyIndex;
  final VoidCallback onReplay;
  final VoidCallback onHome;

  const _CelebrationAnimatedDialog({
    required this.storyIndex,
    required this.onReplay,
    required this.onHome,
  });

  @override
  State<_CelebrationAnimatedDialog> createState() =>
      _CelebrationAnimatedDialogState();
}

class _CelebrationAnimatedDialogState extends State<_CelebrationAnimatedDialog>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _celebrateController;
  late final Animation<double> _entryScale;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    )..forward();
    _entryScale = CurvedAnimation(
      parent: _entryController,
      curve: Curves.elasticOut,
    );
    _celebrateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _celebrateController.dispose();
    super.dispose();
  }

  List<({CharacterPoseSpec pose, double height})> _charactersForStory(
    int storyIndex,
  ) {
    return switch (storyIndex) {
      9 => const [
          (pose: ParquePoseAtlas.mamaOpenArmsProtectiveHug, height: 94),
          (pose: ParquePoseAtlas.pablitoTellingMomEverything, height: 88),
          (pose: ParquePoseAtlas.naranjitoArmsOpenBigSmile, height: 72),
          (pose: ParquePoseAtlas.florecitaHoldingLemonadeGlass, height: 88),
        ],
      8 => const [
          (pose: CosquillasPoseAtlas.pablitoJumpingJoy, height: 90),
          (pose: CosquillasPoseAtlas.florecitaPointingPatioSmiling, height: 90),
          (pose: CosquillasPoseAtlas.naranjitoArmsOpenBigSmile, height: 74),
          (pose: CosquillasPoseAtlas.companeroInvitingOpenHand, height: 90),
        ],
      7 => const [
          (pose: CarritoPoseAtlas.florecitaSharingCarBothHands, height: 92),
          (pose: CarritoPoseAtlas.naranjitoArmsOpenBigSmile, height: 80),
          (pose: CarritoPoseAtlas.pablitoHappyThumbsUp, height: 92),
        ],
      6 => const [
          (pose: PiezaPoseAtlas.florecitaDeterminedHappyFist, height: 92),
          (pose: PiezaPoseAtlas.naranjitoArmsOpenBigSmile, height: 80),
          (pose: PiezaPoseAtlas.pablitoPointingToBlueSofa, height: 92),
        ],
      5 => const [
          (pose: JuegosPoseAtlas.florecitaHappyHandsChest, height: 92),
          (pose: JuegosPoseAtlas.naranjitoArmsOpenBigSmile, height: 80),
          (pose: JuegosPoseAtlas.pablitoJumpingHappy, height: 94),
        ],
      4 => const [
          (pose: CompaneraPoseAtlas.florecitaWavingHello, height: 92),
          (pose: CompaneraPoseAtlas.companeraArmsWideOpenHappy, height: 94),
          (pose: CompaneraPoseAtlas.naranjitoHappyThumbsUp, height: 74),
          (pose: CompaneraPoseAtlas.pablitoArmsRaisedExcited, height: 92),
        ],
      3 => const [
          (pose: PapalotePoseAtlas.papaHandOnHeartProud, height: 98),
          (pose: PapalotePoseAtlas.pablitoHoldingKiteHappy, height: 90),
          (pose: PapalotePoseAtlas.naranjitoHappyThumbsUp, height: 74),
          (pose: PapalotePoseAtlas.florecitaHappyGratefulHands, height: 90),
        ],
      2 => const [
          (pose: BurbujaPoseAtlas.tiaHighFiveRaised, height: 98),
          (pose: BurbujaPoseAtlas.florecitaHappyHandsCheeks, height: 90),
          (pose: BurbujaPoseAtlas.naranjitoHappyThumbsUp, height: 74),
          (pose: BurbujaPoseAtlas.pablitoJumpingJoy, height: 90),
        ],
      1 => const [
          (pose: NubePoseAtlas.florecitaClappingHappy, height: 94),
          (pose: NubePoseAtlas.naranjitoHoldingUmbrella, height: 80),
          (pose: NubePoseAtlas.pablitoCarryingCushionHappy, height: 94),
        ],
      _ => const [
          (pose: CrayonPoseAtlas.maestraProudCongratulating, height: 98),
          (pose: CrayonPoseAtlas.florecitaHappyGrateful, height: 90),
          (pose: CrayonPoseAtlas.naranjitoThumbsUp, height: 74),
          (pose: CrayonPoseAtlas.pablitoWavingHappy, height: 90),
        ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final chars = _charactersForStory(widget.storyIndex);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: ScaleTransition(
        scale: _entryScale,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF7),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFFFF9800), width: 6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Stack(
              children: [
                // Continuous celebratory confetti & sparkles overlay
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _celebrateController,
                      builder: (context, _) {
                        return CustomPaint(
                          painter: _CelebrationConfettiPainter(
                            progress: _celebrateController.value,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated "¡Felicidades!" celebration banner
                        AnimatedBuilder(
                          animation: _celebrateController,
                          builder: (context, _) {
                            final t = _celebrateController.value;
                            final pulse =
                                1.0 + math.sin(t * math.pi * 4) * 0.045;
                            final tilt = math.sin(t * math.pi * 4) * 0.16;
                            return Transform.scale(
                              scale: pulse,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFB300),
                                      Color(0xFFFF6D00),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF8F00)
                                          .withValues(alpha: 0.42),
                                      blurRadius: 16,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Transform.rotate(
                                      angle: tilt,
                                      child: const Icon(
                                        Icons.celebration_rounded,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      '¡Felicidades!',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Transform.rotate(
                                      angle: -tilt,
                                      child: const Icon(
                                        Icons.auto_awesome_rounded,
                                        color: Color(0xFFFFF59D),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Characters celebrating with joyful bounce animation
                        AnimatedBuilder(
                          animation: _celebrateController,
                          builder: (context, _) {
                            final t = _celebrateController.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(chars.length, (idx) {
                                final item = chars[idx];
                                final dy =
                                    math.sin(t * math.pi * 4 + idx * 1.15) *
                                        5.5;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: idx == 0 ? 0 : 10,
                                  ),
                                  child: Transform.translate(
                                    offset: Offset(0, dy),
                                    child: CharacterPoseWidget(
                                      pose: item.pose,
                                      height: item.height,
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Giant icon-only buttons (Replay or Go Home)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _RoundKidsButton(
                              icon: Icons.replay_rounded,
                              color: const Color(0xFFFF9800),
                              size: 76,
                              onTap: widget.onReplay,
                            ),
                            _RoundKidsButton(
                              icon: Icons.home_rounded,
                              color: const Color(0xFF43A047),
                              size: 76,
                              onTap: widget.onHome,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CelebrationConfettiPainter extends CustomPainter {
  final double progress;

  _CelebrationConfettiPainter({required this.progress});

  static const _palette = [
    Color(0xFFFF8F00),
    Color(0xFFFFD54F),
    Color(0xFFFF5252),
    Color(0xFF66BB6A),
    Color(0xFF29B6F6),
    Color(0xFFAB47BC),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const count = 28;
    for (var i = 0; i < count; i++) {
      final seed = i * 1.6180339;
      final baseX = ((seed * 137.5) % 100) / 100.0 * size.width;
      final speed = 1 + (i % 3);
      final fallT = (progress * speed + (seed % 1.0)) % 1.0;
      final x = baseX + math.sin(fallT * math.pi * 4 + seed) * 14;
      final y = fallT * (size.height + 24) - 12;

      paint.color = _palette[i % _palette.length].withValues(alpha: 0.72);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(fallT * math.pi * 4 + seed);
      if (i.isEven) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(-5, -3, 10, 6),
            const Radius.circular(2),
          ),
          paint,
        );
      } else {
        canvas.drawCircle(Offset.zero, 4.2, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _CelebrationConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
