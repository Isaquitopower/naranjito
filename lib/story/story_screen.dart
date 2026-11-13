import 'dart:async';

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
  bool _narrationCompletedForScene = false;
  int _playbackSessionId = 0;
  Timer? _autoAdvanceTimer;
  final ValueNotifier<double> _progressNotifier = ValueNotifier<double>(0.0);

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

  Future<void> _seekToSceneBeatAndChar(int sceneIdx, int beatIdx, int charOffset) async {
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    VoiceNarratorService.instance.stop();

    setState(() {
      _sceneIndex = sceneIdx;
      _beatIndex = beatIdx;
      _charOffset = charOffset;
      _narrationCompletedForScene = false;
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
      _playCurrentSceneScript(fromBeatIndex: beatIdx, fromCharOffset: charOffset);
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
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    _pulseController.dispose();
    VoiceNarratorService.instance.stop();
    super.dispose();
  }

  void _togglePause() {
    if (_isPaused) {
      // Resume
      setState(() {
        _isPaused = false;
      });
      if (_narrationCompletedForScene) {
        // Resume auto-advance timer if scene was finished
        _autoAdvanceTimer = Timer(const Duration(seconds: 3), () {
          if (!mounted || _isPaused) return;
          if (_sceneIndex < _scenes.length - 1) {
            _goToScene(_sceneIndex + 1);
          } else {
            _showVisualCelebrationModal();
          }
        });
      } else {
        // Resume narration exactly from the saved character offset of the current beat
        _playCurrentSceneScript(
          fromBeatIndex: _beatIndex,
          fromCharOffset: _charOffset,
        );
      }
    } else {
      // Pause exactly where it currently is speaking
      _playbackSessionId++;
      _autoAdvanceTimer?.cancel();
      final pausedOffset = VoiceNarratorService.instance.pauseNarration();
      setState(() {
        _isPaused = true;
        _charOffset = pausedOffset;
      });
      _game.setActiveSpeaker(null);
    }
  }

  Future<void> _playCurrentSceneScript({
    int fromBeatIndex = 0,
    int fromCharOffset = 0,
  }) async {
    _autoAdvanceTimer?.cancel();
    final sessionId = ++_playbackSessionId;
    await VoiceNarratorService.instance.stop();

    if (!mounted || _isPaused) return;
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
      if (!mounted || sessionId != _playbackSessionId || _isPaused) return;

      // Completed this beat normally, reset offset for next beats
      _charOffset = 0;

      // Natural pause between story beats
      await Future<void>.delayed(const Duration(milliseconds: 350));
    }

    if (!mounted || sessionId != _playbackSessionId || _isPaused) return;

    setState(() {
      _charOffset = 0;
      _narrationCompletedForScene = true;
    });
    _game.setActiveSpeaker(null);

    // Linear story auto-advance after a short pause
    _autoAdvanceTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted || sessionId != _playbackSessionId || _isPaused) return;
      if (_sceneIndex < _scenes.length - 1) {
        _goToScene(_sceneIndex + 1);
      } else {
        _showVisualCelebrationModal();
      }
    });
  }

  Future<void> _speakSingleInteraction(
    String phrase, {
    double pitch = 1.2,
    String speakerId = 'narrador',
  }) async {
    _autoAdvanceTimer?.cancel();
    final sessionId = ++_playbackSessionId;
    await VoiceNarratorService.instance.stop();

    if (!mounted) return;
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
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    await VoiceNarratorService.instance.stop();
    if (!mounted) return;

    setState(() {
      _sceneIndex = newIndex;
      _beatIndex = 0;
      _isPaused = false;
      _narrationCompletedForScene = false;
    });
    await _game.loadScene(newIndex);
    if (!mounted) return;
    _playCurrentSceneScript();
  }

  void _showVisualCelebrationModal() {
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    _game.setActiveSpeaker(null);
    _game.triggerAllCharactersDance();

    final completionVoice = switch (widget.storyIndex) {
      9 =>
        '¡Muy bien! Pablito no aceptó regalos de un desconocido y fue inmediatamente con su mamá para contarle todo y estar seguro.',
      8 =>
        '¡Muy bien! Florecita usó su voz fuerte y valiente para decir que no quería cosquillas y todos aprendieron a respetar sus límites.',
      7 =>
        '¡Muy bien! Pablito aprendió a pedir el carrito por favor con respeto y a esperar su turno mientras jugaban juntos.',
      6 =>
        '¡Muy bien! Florecita aprendió a respirar profundo como un globo y a buscar una solución con tranquilidad junto a Pablito.',
      5 =>
        '¡Muy bien! Pablito y Florecita aprendieron que los mejores juegos son aquellos en los que todos nos cuidamos y podemos sonreír.',
      4 =>
        '¡Muy bien! Florecita y Pablito invitaron a jugar a la niña nueva y ahora tienen una gran amiga.',
      3 =>
        '¡Muy bien! Pablito aprendió que pedir ayuda a un adulto de confianza también es de valientes.',
      2 =>
        '¡Muy bien! Florecita cuidó su burbuja personal con respeto y chocó esos cinco con su tía.',
      1 =>
        '¡Muy bien! Pablito conoció su nube de tormenta y construyó una cueva gigante muy divertida con Florecita.',
      _ =>
        '¡Muy bien! Florecita fue muy valiente y honesta al hablar con su maestra.',
    };

    VoiceNarratorService.instance.speak(
      completionVoice,
      pitch: 1.22,
      rate: 0.46,
    );

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.all(28),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 3 Golden Stars (100% visual, zero text)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB300),
                      size: 56,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFF8F00),
                      size: 74,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB300),
                      size: 56,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Characters celebrating together in their happy final poses
                if (widget.storyIndex == 9)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: ParquePoseAtlas.mamaOpenArmsProtectiveHug,
                        height: 98,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: ParquePoseAtlas.pablitoTellingMomEverything,
                        height: 92,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: ParquePoseAtlas.naranjitoArmsOpenBigSmile,
                        height: 74,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: ParquePoseAtlas.florecitaHoldingLemonadeGlass,
                        height: 92,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 8)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: CosquillasPoseAtlas.pablitoJumpingJoy,
                        height: 94,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: CosquillasPoseAtlas.florecitaPointingPatioSmiling,
                        height: 94,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: CosquillasPoseAtlas.naranjitoArmsOpenBigSmile,
                        height: 76,
                      ),
                      SizedBox(width: 8),
                      CharacterPoseWidget(
                        pose: CosquillasPoseAtlas.companeroInvitingOpenHand,
                        height: 94,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 7)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: CarritoPoseAtlas.florecitaSharingCarBothHands,
                        height: 96,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: CarritoPoseAtlas.naranjitoArmsOpenBigSmile,
                        height: 82,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: CarritoPoseAtlas.pablitoHappyThumbsUp,
                        height: 96,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 6)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: PiezaPoseAtlas.florecitaDeterminedHappyFist,
                        height: 96,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: PiezaPoseAtlas.naranjitoArmsOpenBigSmile,
                        height: 82,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: PiezaPoseAtlas.pablitoPointingToBlueSofa,
                        height: 96,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 5)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: JuegosPoseAtlas.florecitaHappyHandsChest,
                        height: 96,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: JuegosPoseAtlas.naranjitoArmsOpenBigSmile,
                        height: 82,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: JuegosPoseAtlas.pablitoJumpingHappy,
                        height: 98,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 4)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: CompaneraPoseAtlas.florecitaWavingHello,
                        height: 95,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CompaneraPoseAtlas.companeraArmsWideOpenHappy,
                        height: 98,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CompaneraPoseAtlas.naranjitoHappyThumbsUp,
                        height: 75,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CompaneraPoseAtlas.pablitoArmsRaisedExcited,
                        height: 95,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 3)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: PapalotePoseAtlas.papaHandOnHeartProud,
                        height: 105,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: PapalotePoseAtlas.pablitoHoldingKiteHappy,
                        height: 95,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: PapalotePoseAtlas.naranjitoHappyThumbsUp,
                        height: 75,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: PapalotePoseAtlas.florecitaHappyGratefulHands,
                        height: 95,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 2)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: BurbujaPoseAtlas.tiaHighFiveRaised,
                        height: 105,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: BurbujaPoseAtlas.florecitaHappyHandsCheeks,
                        height: 95,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: BurbujaPoseAtlas.naranjitoHappyThumbsUp,
                        height: 75,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: BurbujaPoseAtlas.pablitoJumpingJoy,
                        height: 95,
                      ),
                    ],
                  )
                else if (widget.storyIndex == 1)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: NubePoseAtlas.florecitaClappingHappy,
                        height: 98,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: NubePoseAtlas.naranjitoHoldingUmbrella,
                        height: 82,
                      ),
                      SizedBox(width: 12),
                      CharacterPoseWidget(
                        pose: NubePoseAtlas.pablitoCarryingCushionHappy,
                        height: 98,
                      ),
                    ],
                  )
                else
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CharacterPoseWidget(
                        pose: CrayonPoseAtlas.maestraProudCongratulating,
                        height: 105,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CrayonPoseAtlas.florecitaHappyGrateful,
                        height: 95,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CrayonPoseAtlas.naranjitoThumbsUp,
                        height: 75,
                      ),
                      SizedBox(width: 10),
                      CharacterPoseWidget(
                        pose: CrayonPoseAtlas.pablitoWavingHappy,
                        height: 95,
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                // Giant icon-only buttons (Replay or Go Home)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _RoundKidsButton(
                      icon: Icons.replay_rounded,
                      color: const Color(0xFFFF9800),
                      size: 78,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        _goToScene(0);
                      },
                    ),
                    _RoundKidsButton(
                      icon: Icons.home_rounded,
                      color: const Color(0xFF43A047),
                      size: 78,
                      onTap: () {
                        VoiceNarratorService.instance.stop();
                        Navigator.of(ctx).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                      _playbackSessionId++;
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
