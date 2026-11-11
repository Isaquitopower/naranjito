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
  bool _isSpeaking = false;
  bool _narrationCompletedForScene = false;
  int _playbackSessionId = 0;
  Timer? _autoAdvanceTimer;

  late final StoryFlameGame _game;
  late final AnimationController _pulseController;

  List<StorySceneData> get _scenes => getStoryScenes(widget.storyIndex);

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
    });
  }

  @override
  void dispose() {
    _playbackSessionId++;
    _autoAdvanceTimer?.cancel();
    _pulseController.dispose();
    VoiceNarratorService.instance.stop();
    super.dispose();
  }

  Future<void> _playCurrentSceneScript() async {
    _autoAdvanceTimer?.cancel();
    final sessionId = ++_playbackSessionId;
    await VoiceNarratorService.instance.stop();

    if (!mounted) return;
    final scene = _scenes[_sceneIndex];

    setState(() {
      _isSpeaking = true;
      _narrationCompletedForScene = false;
    });

    for (final beat in scene.beats) {
      if (!mounted || sessionId != _playbackSessionId) return;

      // Update each character's exact pose and position for this beat
      _game.applyVoiceBeat(beat);

      final completer = Completer<void>();
      await VoiceNarratorService.instance.speak(
        beat.text,
        pitch: beat.pitch,
        rate: beat.rate,
        onDone: () {
          if (!completer.isCompleted) {
            completer.complete();
          }
        },
      );

      await completer.future;
      if (!mounted || sessionId != _playbackSessionId) return;

      // Natural pause between story beats
      await Future<void>.delayed(const Duration(milliseconds: 350));
    }

    if (!mounted || sessionId != _playbackSessionId) return;

    setState(() {
      _isSpeaking = false;
      _narrationCompletedForScene = true;
    });
    _game.setActiveSpeaker(null);

    // Linear story auto-advance after a short pause
    _autoAdvanceTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted || sessionId != _playbackSessionId) return;
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
    setState(() {
      _isSpeaking = true;
    });
    _game.setActiveSpeaker(speakerId);

    await VoiceNarratorService.instance.speak(
      phrase,
      pitch: pitch,
      rate: 0.46,
      onDone: () {
        if (!mounted || sessionId != _playbackSessionId) return;
        setState(() {
          _isSpeaking = false;
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
    final isLastScene = _sceneIndex == _scenes.length - 1;

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

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: const Color(0xFFFFB74D),
                        width: 3.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _scenes.length,
                        (idx) {
                          final isCompletedOrCurrent = idx <= _sceneIndex;
                          final isCurrent = idx == _sceneIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              Icons.favorite_rounded,
                              size: isCurrent ? 30 : 22,
                              color: isCompletedOrCurrent
                                  ? const Color(0xFFFF6D00)
                                  : const Color(0xFFFFCC80),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _RoundKidsButton(
                        icon: Icons.settings_rounded,
                        color: const Color(0xFF8E24AA),
                        size: 56,
                        onTap: () => showAppSettingsDialog(context),
                      ),
                      const SizedBox(width: 12),
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final scale = _isSpeaking
                              ? 1.0 + (_pulseController.value * 0.14)
                              : 1.0;
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: _RoundKidsButton(
                          icon: _isSpeaking
                              ? Icons.volume_up_rounded
                              : Icons.record_voice_over_rounded,
                          color: _isSpeaking
                              ? const Color(0xFF43A047)
                              : const Color(0xFFFFB300),
                          size: 62,
                          onTap: _playCurrentSceneScript,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom Left & Right Linear Navigation Arrows (Pure icons, zero text)
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_sceneIndex > 0)
                      _RoundKidsButton(
                        icon: Icons.arrow_back_rounded,
                        color: const Color(0xFF29B6F6),
                        size: 68,
                        onTap: () => _goToScene(_sceneIndex - 1),
                      )
                    else
                      const SizedBox(width: 68),

                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = _narrationCompletedForScene
                            ? 1.0 + (_pulseController.value * 0.16)
                            : 1.0;
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: _RoundKidsButton(
                        icon: isLastScene
                            ? Icons.star_rounded
                            : Icons.arrow_forward_rounded,
                        color: isLastScene
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFFF8F00),
                        size: 74,
                        onTap: () {
                          if (isLastScene) {
                            _showVisualCelebrationModal();
                          } else {
                            _goToScene(_sceneIndex + 1);
                          }
                        },
                      ),
                    ),
                  ],
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
