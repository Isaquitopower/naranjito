import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import 'soundtrack_service.dart';
import 'story_data.dart';

class StoryFlameGame extends FlameGame {
  final int storyIndex;
  final VoidCallback? onSceneReady;
  final void Function(String spokenText, double pitch, String speakerId)?
      onSpeakRequest;

  StoryFlameGame({
    this.storyIndex = 0,
    this.onSceneReady,
    this.onSpeakRequest,
  });

  static final Map<String, ui.Image> _sharedImageCache = {};
  static final Map<String, Future<ui.Image>> _inFlightLoads = {};
  static int? _cachedStoryIndex;

  static Future<ui.Image> _loadCachedImage(String relativePath) {
    final existing = _sharedImageCache[relativePath];
    if (existing != null) {
      return Future<ui.Image>.value(existing);
    }
    return _inFlightLoads.putIfAbsent(relativePath, () async {
      Flame.images.prefix = 'assets/images/';
      final img = await Flame.images.load(relativePath);
      _sharedImageCache[relativePath] = img;
      return img;
    });
  }

  /// Preloads all assets needed for the first scene of [storyIndex] in parallel,
  /// and evicts previous stories' heavy sprite sheets to keep memory usage low.
  static Future<void> preloadStoryAssets(
    int storyIndex, {
    bool firstSceneOnly = false,
  }) async {
    if (_cachedStoryIndex != null && _cachedStoryIndex != storyIndex) {
      Flame.images.clearCache();
      _sharedImageCache.clear();
      _inFlightLoads.clear();
    }
    _cachedStoryIndex = storyIndex;

    final scenes = getStoryScenes(storyIndex);
    if (scenes.isEmpty) return;

    final targetScenes = firstSceneOnly ? [scenes.first] : scenes;
    final paths = <String>{};
    for (final scene in targetScenes) {
      paths.add(scene.backgroundAsset);
      for (final placement in scene.characters) {
        paths.add(placement.initialPose.sheetFileName);
      }
      for (final beat in scene.beats) {
        for (final pose in beat.poseChanges.values) {
          paths.add(pose.sheetFileName);
        }
      }
    }

    await Future.wait(paths.map(_loadCachedImage));
  }

  int _currentSceneIndex = 0;
  String? _activeSpeakerId;
  String? _lastSpeakerId;
  late StoryBackdropComponent _backdrop;
  final List<Component> _sceneComponents = [];

  bool _isLoaded = false;

  List<StorySceneData> get _scenes => getStoryScenes(storyIndex);

  @override
  Color backgroundColor() => const Color(0xFFFFCC80);

  void setActiveSpeaker(String? speakerId) {
    _activeSpeakerId = speakerId;
    for (final comp in _sceneComponents) {
      if (comp is StoryCharacterComponent) {
        if (speakerId == 'narrador') {
          comp.isTalking = false;
        } else {
          comp.isTalking = (comp.characterId == speakerId);
        }
      }
    }
  }

  /// Applies exact character poses and optional position shifts for the current story beat
  void applyVoiceBeat(VoiceBeat beat) {
    setActiveSpeaker(beat.speakerId);

    for (final comp in _sceneComponents) {
      if (comp is StoryCharacterComponent) {
        final newPose = beat.poseChanges[comp.characterId];
        if (newPose != null) {
          comp.updatePose(
            newPose,
            newSheetImage: _sharedImageCache[newPose.sheetFileName],
          );
        }

        final newNormPos = beat.positionChanges[comp.characterId];
        if (newNormPos != null && size.x > 0 && size.y > 0) {
          comp.moveToNormalized(
            Vector2(size.x * newNormPos.dx, size.y * newNormPos.dy),
          );
        }
      }
    }

    _updateCharacterFacings(beat: beat);
    if (beat.speakerId != 'narrador') {
      _lastSpeakerId = beat.speakerId;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 1. Load only the first scene's assets in parallel for instant display
    await preloadStoryAssets(storyIndex, firstSceneOnly: true);

    final initialBg =
        _sharedImageCache[_scenes[_currentSceneIndex].backgroundAsset];
    _backdrop = StoryBackdropComponent(backgroundImage: initialBg);
    await add(_backdrop);

    _isLoaded = true;
    _buildScene(_currentSceneIndex);
    onSceneReady?.call();

    // 2. Preload any remaining scenes of this story in the background
    if (_scenes.length > 1) {
      unawaited(preloadStoryAssets(storyIndex, firstSceneOnly: false));
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_isLoaded) {
      _buildScene(_currentSceneIndex);
    }
  }

  Future<void> loadScene(int index) async {
    if (index < 0 || index >= _scenes.length) return;
    _currentSceneIndex = index;
    if (!_isLoaded) return;

    await preloadStoryAssets(storyIndex, firstSceneOnly: false);

    final bgImage = _sharedImageCache[_scenes[index].backgroundAsset];
    _backdrop.updateBackground(bgImage);
    _buildScene(index);
  }

  void _buildScene(int index) {
    for (final comp in _sceneComponents) {
      comp.removeFromParent();
    }
    _sceneComponents.clear();
    _lastSpeakerId = null;

    if (size.x == 0 || size.y == 0) return;

    final scene = _scenes[index];

    // Add interactive props for this scene
    for (final propData in scene.props) {
      final pos = Vector2(
        size.x * propData.normalizedPosition.dx,
        size.y * propData.normalizedPosition.dy,
      );
      final propComp = InteractivePropComponent(
        propData: propData,
        position: pos,
        onTapped: () {
          spawnCelebrationParticles(pos);
          onSpeakRequest?.call(propData.spokenSound, 1.25, 'narrador');
        },
      );
      add(propComp);
      _sceneComponents.add(propComp);
    }

    // Add animated characters with their initial pose from the collage
    for (final placement in scene.characters) {
      final sheetImg =
          _sharedImageCache[placement.initialPose.sheetFileName];
      if (sheetImg == null) continue;

      final baseHeight =
          math.min(size.y * 0.52, size.x * 0.32) * placement.scale;
      final aspect = placement.initialPose.aspectRatio;
      final charSize = Vector2(baseHeight * aspect, baseHeight);

      final pos = Vector2(
        size.x * placement.normalizedPosition.dx,
        size.y * placement.normalizedPosition.dy,
      );

      final charComp = StoryCharacterComponent(
        characterId: placement.characterId,
        sheetImage: sheetImg,
        initialPose: placement.initialPose,
        baseHeight: baseHeight,
        position: pos,
        size: charSize,
        initialEmotion: placement.initialEmotion,
        spokenPhrase: placement.spokenPhrase,
        voicePitch: placement.voicePitch,
        isTalking: _activeSpeakerId == placement.characterId,
        onCharacterTapped: (phrase, pitch, charId, tapPos) {
          spawnCelebrationParticles(tapPos);
          onSpeakRequest?.call(phrase, pitch, charId);
        },
      );
      add(charComp);
      _sceneComponents.add(charComp);
    }

    _updateCharacterFacings();
  }

  /// Dynamically mirrors characters horizontally so they always face the
  /// character they are speaking with or listening to, instead of looking
  /// toward an empty screen edge.
  void _updateCharacterFacings({VoiceBeat? beat}) {
    final characters =
        _sceneComponents.whereType<StoryCharacterComponent>().toList();
    if (characters.length < 2) return;

    StoryCharacterComponent? speakerComp;
    if (beat != null && beat.speakerId != 'narrador') {
      for (final comp in characters) {
        if (comp.characterId == beat.speakerId) {
          speakerComp = comp;
          break;
        }
      }
    }

    // When no specific character is speaking (scene start or narrator beat),
    // orient every character inward toward the horizontal center of the group.
    if (speakerComp == null || beat == null) {
      final groupCenterX = characters.fold<double>(
            0.0,
            (sum, c) => sum + c.targetX,
          ) /
          characters.length;
      for (final comp in characters) {
        comp.setFacingDirection(faceRight: comp.targetX <= groupCenterX);
      }
      return;
    }

    final others = characters.where((c) => c != speakerComp).toList();
    if (others.isEmpty) return;

    // 1. Orient the active speaker toward the character they are addressing
    final interlocutorX = _resolveSpeakerInterlocutorX(
      speakerComp,
      others,
      beat,
    );
    speakerComp.setFacingDirection(
      faceRight: interlocutorX >= speakerComp.targetX,
    );

    // 2. Orient all other characters in the scene to look toward the speaker
    for (final listener in others) {
      listener.setFacingDirection(
        faceRight: speakerComp.targetX >= listener.targetX,
      );
    }
  }

  double _resolveSpeakerInterlocutorX(
    StoryCharacterComponent speaker,
    List<StoryCharacterComponent> others,
    VoiceBeat beat,
  ) {
    // If all other characters are on the same horizontal side of the speaker,
    // the speaker naturally faces that side.
    final allToRight = others.every((c) => c.targetX >= speaker.targetX);
    if (allToRight) {
      return others.first.targetX;
    }
    final allToLeft = others.every((c) => c.targetX <= speaker.targetX);
    if (allToLeft) {
      return others.first.targetX;
    }

    // Speaker is between characters on both left and right: determine who is addressed.
    final textLower = beat.text.toLowerCase();

    StoryCharacterComponent? findOther(String id) {
      for (final c in others) {
        if (c.characterId == id) return c;
      }
      return null;
    }

    // Direct mention of Naranjito
    if (textLower.contains('naranjito')) {
      final naranjito = findOther('naranjito');
      if (naranjito != null) return naranjito.targetX;
    }

    // Direct vocative / address to another character in the scene
    const characterKeywords = <String, List<String>>{
      'florecita': ['florecita'],
      'pablito': ['pablito', 'amiguito'],
      'maestra': ['maestra'],
      'tia': ['tía', 'tia'],
      'papa': ['papá', 'papa', 'señor'],
      'mama': ['mamá', 'mama', 'mami'],
      'companera': ['compañerita', 'niña nueva'],
      'companero': ['niño mayor', 'monstruo', 'déjala', 'dejala'],
      'desconocido': ['no, muchas gracias', 'no quiero sus regalos'],
    };

    for (final entry in characterKeywords.entries) {
      final targetComp = findOther(entry.key);
      if (targetComp == null) continue;
      for (final kw in entry.value) {
        if (textLower.contains(kw)) {
          // Avoid switching away from Naranjito if answering Naranjito ABOUT a third party
          final isThirdPartyReference = _lastSpeakerId == 'naranjito' &&
              (textLower.contains('florecita lo tiene') ||
                  textLower.contains('cuando ella') ||
                  textLower.contains('mi mamá me enseñó') ||
                  textLower.contains('mi mamá me dice') ||
                  textLower.contains('ir con mi mamá') ||
                  textLower.contains('enseñárselo a mi mamá') ||
                  textLower.contains('mi mamá podrá'));
          if (!isThirdPartyReference) {
            return targetComp.targetX;
          }
        }
      }
    }

    // Otherwise, face the previous speaker if they are in the scene
    if (_lastSpeakerId != null && _lastSpeakerId != speaker.characterId) {
      final prevSpeaker = findOther(_lastSpeakerId!);
      if (prevSpeaker != null) {
        return prevSpeaker.targetX;
      }
    }

    // Otherwise, prefer a non-Naranjito peer in the scene
    final nonNaranjito =
        others.where((c) => c.characterId != 'naranjito').toList();
    if (nonNaranjito.isNotEmpty) {
      return nonNaranjito.first.targetX;
    }

    return others.first.targetX;
  }

  void triggerAllCharactersDance() {
    for (final comp in _sceneComponents) {
      if (comp is StoryCharacterComponent) {
        comp.playExcitedJump();
      }
    }
    if (size.x > 0 && size.y > 0) {
      spawnCelebrationParticles(Vector2(size.x * 0.3, size.y * 0.45));
      spawnCelebrationParticles(Vector2(size.x * 0.5, size.y * 0.35));
      spawnCelebrationParticles(Vector2(size.x * 0.7, size.y * 0.45));
    }
  }

  void spawnCelebrationParticles(Vector2 position, {Color? color}) {
    final random = math.Random();
    final palette = [
      const Color(0xFFFF8A00),
      const Color(0xFFFFD54F),
      const Color(0xFFFF5252),
      const Color(0xFF69F0AE),
      const Color(0xFF40C4FF),
      const Color(0xFFE040FB),
    ];

    add(
      ParticleSystemComponent(
        position: position.clone(),
        priority: 50,
        particle: Particle.generate(
          count: 18,
          lifespan: 1.1,
          generator: (i) {
            final angle = (i / 18) * math.pi * 2 + random.nextDouble() * 0.3;
            final speed = 60.0 + random.nextDouble() * 110.0;
            final velocity = Vector2(math.cos(angle), math.sin(angle)) * speed;
            final particleColor =
                color ?? palette[random.nextInt(palette.length)];

            return AcceleratedParticle(
              acceleration: Vector2(0, 140),
              speed: velocity,
              child: ComputedParticle(
                renderer: (canvas, particle) {
                  final progress = 1.0 - particle.progress;
                  final paint = Paint()
                    ..color = particleColor.withValues(
                      alpha: progress.clamp(0.0, 1.0),
                    )
                    ..style = PaintingStyle.fill;

                  final radius = (6.0 + (i % 3) * 3.0) * progress;
                  if (i.isEven) {
                    canvas.save();
                    canvas.rotate(particle.progress * 4);
                    final path = Path()
                      ..moveTo(0, -radius * 1.4)
                      ..lineTo(radius * 0.5, -radius * 0.5)
                      ..lineTo(radius * 1.4, 0)
                      ..lineTo(radius * 0.5, radius * 0.5)
                      ..lineTo(0, radius * 1.4)
                      ..lineTo(-radius * 0.5, radius * 0.5)
                      ..lineTo(-radius * 1.4, 0)
                      ..lineTo(-radius * 0.5, -radius * 0.5)
                      ..close();
                    canvas.drawPath(path, paint);
                    canvas.restore();
                  } else {
                    canvas.drawCircle(Offset.zero, radius, paint);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class StoryBackdropComponent extends PositionComponent
    with HasGameReference<StoryFlameGame> {
  ui.Image? backgroundImage;
  double _time = 0;

  StoryBackdropComponent({required this.backgroundImage}) : super(priority: -10);

  void updateBackground(ui.Image? newImage) {
    backgroundImage = newImage;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final w = size.x;
    final h = size.y;
    if (w == 0 || h == 0) return;

    final img = backgroundImage;
    if (img != null) {
      final src = Rect.fromLTWH(
        0,
        0,
        img.width.toDouble(),
        img.height.toDouble(),
      );
      final dst = Rect.fromLTWH(0, 0, w, h);
      canvas.drawImageRect(
        img,
        src,
        dst,
        Paint()..filterQuality = FilterQuality.medium,
      );
    } else {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFFFFE0B2),
      );
    }

    // Subtle magical classroom dust / sunlight motes floating in the air
    final sparklePaint = Paint()
      ..color = const Color(0xFFFFF9C4).withValues(alpha: 0.65);
    for (int i = 0; i < 8; i++) {
      final sx = (w * (0.12 * i + 0.08)) + math.sin(_time * 1.3 + i) * 18;
      final sy = (h * 0.35) + math.cos(_time * 1.1 + i * 1.7) * 45;
      final sr = 2.5 + (math.sin(_time * 2.6 + i) + 1.0) * 1.8;
      canvas.drawCircle(Offset(sx, sy), sr, sparklePaint);
    }
  }
}

class StoryCharacterComponent extends PositionComponent with TapCallbacks {
  final String characterId;
  ui.Image sheetImage;
  CharacterPoseSpec _currentPose;
  final double baseHeight;
  final String initialEmotion;
  final String spokenPhrase;
  final double voicePitch;
  bool isTalking;
  final void Function(
    String phrase,
    double pitch,
    String charId,
    Vector2 tapPos,
  ) onCharacterTapped;

  late final SpriteComponent _spriteComponent;
  bool _isSpriteMounted = false;
  bool _shouldFaceRight = true;
  double _idleTimer = 0;
  late double _baseY;
  late double _baseX;

  double get targetX => _baseX;

  StoryCharacterComponent({
    required this.characterId,
    required this.sheetImage,
    required CharacterPoseSpec initialPose,
    required this.baseHeight,
    required Vector2 position,
    required Vector2 size,
    required this.initialEmotion,
    required this.spokenPhrase,
    required this.voicePitch,
    required this.isTalking,
    required this.onCharacterTapped,
  })  : _currentPose = initialPose,
        super(
          position: position,
          size: size,
          anchor: Anchor.center,
          priority: 10,
        ) {
    _baseY = position.y;
    _baseX = position.x;
  }

  /// Sets whether this character should visually face toward the right (`true`)
  /// or toward the left (`false`), applying a horizontal mirror effect when needed.
  void setFacingDirection({required bool faceRight}) {
    _shouldFaceRight = faceRight;
    if (_isSpriteMounted) {
      _applyMirrorScale();
    }
  }

  void _applyMirrorScale() {
    final shouldMirror = _shouldFaceRight != _currentPose.originallyFacesRight;
    _spriteComponent.scale = Vector2(shouldMirror ? -1.0 : 1.0, 1.0);
  }

  Sprite _createSpriteForPose(CharacterPoseSpec pose) {
    final r = pose.tightPixelRect;
    return Sprite(
      sheetImage,
      srcPosition: Vector2(r.left, r.top),
      srcSize: Vector2(r.width, r.height),
    );
  }

  /// Dynamically switches the character's pose to the exact cell in the collage
  /// with a lively squash-and-stretch transition.
  void updatePose(CharacterPoseSpec newPose, {ui.Image? newSheetImage}) {
    if (_currentPose.sheetFileName == newPose.sheetFileName &&
        _currentPose.col == newPose.col &&
        _currentPose.row == newPose.row) {
      if (_isSpriteMounted) {
        _applyMirrorScale();
      }
      return;
    }
    if (newSheetImage != null) {
      sheetImage = newSheetImage;
    }
    _currentPose = newPose;

    final newWidth = baseHeight * newPose.aspectRatio;
    size = Vector2(newWidth, baseHeight);
    _spriteComponent.sprite = _createSpriteForPose(newPose);
    _spriteComponent.size = size.clone();
    _spriteComponent.position = size / 2;
    _applyMirrorScale();

    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2(1.08, 0.93),
          EffectController(duration: 0.09, curve: Curves.easeOut),
        ),
        ScaleEffect.to(
          Vector2(0.96, 1.05),
          EffectController(duration: 0.11, curve: Curves.easeOut),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0.18, curve: Curves.easeOutBack),
        ),
      ]),
    );
  }

  void moveToNormalized(Vector2 newPos) {
    _baseX = newPos.x;
    _baseY = newPos.y;
    add(
      MoveToEffect(
        newPos,
        EffectController(duration: 0.75, curve: Curves.easeInOutCubic),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _spriteComponent = SpriteComponent(
      sprite: _createSpriteForPose(_currentPose),
      size: size.clone(),
      position: size / 2,
      anchor: Anchor.center,
    );
    _isSpriteMounted = true;
    _applyMirrorScale();
    await add(_spriteComponent);

    if (initialEmotion == 'appear') {
      scale = Vector2.zero();
      add(
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(
            duration: 0.9,
            curve: Curves.elasticOut,
          ),
        ),
      );
    } else if (initialEmotion == 'walk') {
      position.x = _baseX + (_shouldFaceRight ? -90 : 90);
      add(
        MoveToEffect(
          Vector2(_baseX, _baseY),
          EffectController(
            duration: 0.85,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    } else {
      scale = Vector2.zero();
      add(
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(
            duration: 0.55,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _idleTimer += dt;

    final phase = characterId.hashCode * 0.4;

    if (isTalking) {
      position.y = _baseY + math.sin(_idleTimer * 6.5) * 9.5;
      angle = math.sin(_idleTimer * 4.5) * 0.055;
    } else {
      switch (initialEmotion) {
        case 'sad':
          position.y = _baseY + math.sin(_idleTimer * 1.8 + phase) * 3.5;
          angle = math.sin(_idleTimer * 1.4) * 0.025;
        case 'whisper':
          position.y = _baseY + math.sin(_idleTimer * 2.2 + phase) * 4.0;
          angle = math.sin(_idleTimer * 3.0) * 0.03;
        case 'appear':
          position.y = _baseY + math.sin(_idleTimer * 3.0 + phase) * 6.0;
          angle = math.sin(_idleTimer * 2.0) * 0.035;
        case 'happy':
          position.y =
              _baseY + math.sin(_idleTimer * 3.8 + phase).abs() * -9.0;
          angle = math.sin(_idleTimer * 2.8 + phase) * 0.04;
        default:
          position.y = _baseY + math.sin(_idleTimer * 2.5 + phase) * 5.0;
          angle = math.sin(_idleTimer * 2.0 + phase) * 0.025;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.x * 0.5, size.y * 0.95),
        width: size.x * 0.62,
        height: size.y * 0.10,
      ),
      shadowPaint,
    );

    if (isTalking) {
      final haloPaint = Paint()
        ..color = const Color(0xFFFFF59D).withValues(alpha: 0.55)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
      canvas.drawCircle(
        Offset(size.x * 0.5, size.y * 0.5),
        size.x * 0.54,
        haloPaint,
      );
    }

    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    playExcitedJump();
    onCharacterTapped(spokenPhrase, voicePitch, characterId, position.clone());
  }

  void playExcitedJump() {
    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2(1.16, 0.88),
          EffectController(duration: 0.10, curve: Curves.easeOut),
        ),
        ScaleEffect.to(
          Vector2(0.94, 1.14),
          EffectController(duration: 0.14, curve: Curves.easeOut),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0.35, curve: Curves.elasticOut),
        ),
      ]),
    );

    add(
      SequenceEffect([
        RotateEffect.to(
          0.11,
          EffectController(duration: 0.10, curve: Curves.easeInOut),
        ),
        RotateEffect.to(
          -0.11,
          EffectController(duration: 0.16, curve: Curves.easeInOut),
        ),
        RotateEffect.to(
          0.0,
          EffectController(duration: 0.14, curve: Curves.easeOut),
        ),
      ]),
    );
  }
}

class InteractivePropComponent extends PositionComponent with TapCallbacks {
  final InteractivePropData propData;
  final VoidCallback onTapped;
  double _time = 0;

  InteractivePropComponent({
    required this.propData,
    required Vector2 position,
    required this.onTapped,
  }) : super(
          position: position,
          size: Vector2.all(84),
          anchor: Anchor.center,
          priority: 15,
        );

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    if (!SoundtrackService.instance.visualEffectsEnabled) {
      return false;
    }
    return super.containsLocalPoint(point);
  }

  @override
  void render(Canvas canvas) {
    if (!SoundtrackService.instance.visualEffectsEnabled) {
      return;
    }
    super.render(canvas);
    final center = Offset(size.x / 2, size.y / 2);
    final pulse =
        1.0 + math.sin(_time * 4.0 + propData.spokenSound.hashCode) * 0.09;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(pulse);

    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(Offset.zero, 30, glowPaint);

    switch (propData.type) {
      case 'broken_crayon':
        _drawBrokenRedCrayon(canvas);
      case 'paper_dinosaur':
        _drawPaperDinosaurWithBlueSpots(canvas);
      case 'colorful_ball':
        _drawColorfulBall(canvas);
      case 'storm_cloud':
        _drawStormCloud(canvas);
      case 'orange_umbrella':
        _drawOrangeUmbrella(canvas);
      case 'cozy_cushion':
        _drawCozyCushion(canvas);
      case 'magic_bubble':
        _drawMagicBubble(canvas);
      case 'party_balloon':
        _drawPartyBalloon(canvas);
      case 'birthday_cake':
        _drawBirthdayCake(canvas);
      case 'flying_kite':
        _drawFlyingKite(canvas);
      case 'star':
        _drawStar(canvas);
      case 'heart':
      default:
        _drawHeart(canvas);
    }

    canvas.restore();
  }

  void _drawFlyingKite(Canvas canvas) {
    // Colorful diamond kite with tail bows
    final topLeft = Path()
      ..moveTo(0, -24)
      ..lineTo(-18, -4)
      ..lineTo(0, -4)
      ..close();
    final topRight = Path()
      ..moveTo(0, -24)
      ..lineTo(18, -4)
      ..lineTo(0, -4)
      ..close();
    final bottomLeft = Path()
      ..moveTo(0, 16)
      ..lineTo(-18, -4)
      ..lineTo(0, -4)
      ..close();
    final bottomRight = Path()
      ..moveTo(0, 16)
      ..lineTo(18, -4)
      ..lineTo(0, -4)
      ..close();

    canvas.drawPath(topLeft, Paint()..color = const Color(0xFFE53935));
    canvas.drawPath(topRight, Paint()..color = const Color(0xFFFFCA28));
    canvas.drawPath(bottomLeft, Paint()..color = const Color(0xFF1E88E5));
    canvas.drawPath(bottomRight, Paint()..color = const Color(0xFF43A047));

    // Tail string and colorful bows
    final tailPath = Path()
      ..moveTo(0, 16)
      ..quadraticBezierTo(10, 22, -4, 28);
    canvas.drawPath(
      tailPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );
    canvas.drawCircle(
      const Offset(4, 21),
      3.5,
      Paint()..color = const Color(0xFFFF7043),
    );
    canvas.drawCircle(
      const Offset(-3, 27),
      3.5,
      Paint()..color = const Color(0xFFAB47BC),
    );
  }

  void _drawMagicBubble(Canvas canvas) {
    final fillPaint = Paint()
      ..color = const Color(0xFF80D8FF).withValues(alpha: 0.42);
    final rimPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.92)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2;
    canvas.drawCircle(Offset.zero, 23, fillPaint);
    canvas.drawCircle(Offset.zero, 23, rimPaint);
    canvas.drawArc(
      const Rect.fromLTWH(-16, -16, 32, 32),
      -math.pi * 0.78,
      math.pi * 0.42,
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawPartyBalloon(Canvas canvas) {
    final stringPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(const Offset(0, 14), const Offset(0, 26), stringPaint);
    canvas.drawOval(
      const Rect.fromLTWH(-15, -20, 30, 35),
      Paint()..color = const Color(0xFFEC407A),
    );
    canvas.drawOval(
      const Rect.fromLTWH(-9, -14, 7, 11),
      Paint()..color = Colors.white.withValues(alpha: 0.55),
    );
  }

  void _drawBirthdayCake(Canvas canvas) {
    // Cake base
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-20, -2, 40, 20),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFFFFB74D),
    );
    // Pink frosting
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-21, -5, 42, 8),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFFF48FB1),
    );
    // 3 little candles with flames
    for (final cx in [-10.0, 0.0, 10.0]) {
      canvas.drawRect(
        Rect.fromLTWH(cx - 2, -16, 4, 11),
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        Offset(cx, -19),
        3.2,
        Paint()..color = const Color(0xFFFFCA28),
      );
    }
  }

  void _drawColorfulBall(Canvas canvas) {
    const radius = 22.0;
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    canvas.drawArc(
      rect,
      0,
      math.pi / 2,
      true,
      Paint()..color = const Color(0xFF42A5F5),
    );
    canvas.drawArc(
      rect,
      math.pi / 2,
      math.pi / 2,
      true,
      Paint()..color = const Color(0xFFFFCA28),
    );
    canvas.drawArc(
      rect,
      math.pi,
      math.pi / 2,
      true,
      Paint()..color = const Color(0xFF66BB6A),
    );
    canvas.drawArc(
      rect,
      3 * math.pi / 2,
      math.pi / 2,
      true,
      Paint()..color = const Color(0xFFFF7043),
    );
    canvas.drawCircle(
      Offset.zero,
      6,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  void _drawStormCloud(Canvas canvas) {
    final cloudPaint = Paint()..color = const Color(0xFF78909C);
    canvas.drawCircle(const Offset(-12, -2), 13, cloudPaint);
    canvas.drawCircle(const Offset(2, -8), 16, cloudPaint);
    canvas.drawCircle(const Offset(15, -1), 12, cloudPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-22, -2, 46, 14),
        const Radius.circular(7),
      ),
      cloudPaint,
    );

    final dropPaint = Paint()
      ..color = const Color(0xFF29B6F6)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(-10, 15), const Offset(-13, 23), dropPaint);
    canvas.drawLine(const Offset(1, 16), const Offset(-2, 24), dropPaint);
    canvas.drawLine(const Offset(12, 15), const Offset(9, 23), dropPaint);
  }

  void _drawOrangeUmbrella(Canvas canvas) {
    final handlePaint = Paint()
      ..color = const Color(0xFF1E88E5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, -18), const Offset(0, 16), handlePaint);
    canvas.drawArc(
      const Rect.fromLTWH(-10, 10, 10, 12),
      0,
      math.pi,
      false,
      handlePaint,
    );

    final canopyPaint = Paint()..color = const Color(0xFFFF8F00);
    canvas.drawArc(
      const Rect.fromLTWH(-24, -20, 48, 34),
      math.pi,
      math.pi,
      true,
      canopyPaint,
    );
  }

  void _drawCozyCushion(Canvas canvas) {
    final cushionRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(-20, -18, 40, 36),
      const Radius.circular(10),
    );
    canvas.drawRRect(
      cushionRect,
      Paint()..color = const Color(0xFFEC407A),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-18, -16, 18, 16),
        const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFF42A5F5),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 18, 16),
        const Radius.circular(6),
      ),
      Paint()..color = const Color(0xFFFFCA28),
    );
  }

  void _drawBrokenRedCrayon(Canvas canvas) {
    final crayonPaint = Paint()..color = const Color(0xFFE53935);
    final wrapperPaint = Paint()..color = const Color(0xFFFFCDD2);
    final stripePaint = Paint()..color = const Color(0xFF3E2723);

    canvas.save();
    canvas.translate(-14, 4);
    canvas.rotate(-0.32);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-18, -7, 26, 14),
        const Radius.circular(3),
      ),
      crayonPaint,
    );
    canvas.drawRect(const Rect.fromLTWH(-10, -7, 12, 14), wrapperPaint);
    canvas.drawRect(const Rect.fromLTWH(-12, -7, 3, 14), stripePaint);
    final tipPath = Path()
      ..moveTo(-18, -7)
      ..lineTo(-28, 0)
      ..lineTo(-18, 7)
      ..close();
    canvas.drawPath(tipPath, crayonPaint);
    canvas.restore();

    canvas.save();
    canvas.translate(14, 4);
    canvas.rotate(0.35);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-6, -7, 24, 14),
        const Radius.circular(3),
      ),
      crayonPaint,
    );
    canvas.drawRect(const Rect.fromLTWH(-2, -7, 12, 14), wrapperPaint);
    canvas.drawRect(const Rect.fromLTWH(10, -7, 3, 14), stripePaint);
    canvas.restore();
  }

  void _drawPaperDinosaurWithBlueSpots(Canvas canvas) {
    final dinoPaint = Paint()..color = const Color(0xFFD7CCC8);
    final spotPaint = Paint()..color = const Color(0xFF1E88E5);

    // Dinosaur body and long neck
    final path = Path()
      ..moveTo(-22, 12)
      ..quadraticBezierTo(-10, -8, 6, -4)
      ..lineTo(14, -22)
      ..quadraticBezierTo(24, -24, 24, -14)
      ..lineTo(14, 6)
      ..lineTo(14, 18)
      ..lineTo(6, 18)
      ..lineTo(6, 10)
      ..lineTo(-6, 10)
      ..lineTo(-6, 18)
      ..lineTo(-14, 18)
      ..lineTo(-14, 12)
      ..close();
    canvas.drawPath(path, dinoPaint);

    // Big blue painted spots mentioned by Pablito!
    canvas.drawCircle(const Offset(-4, 2), 4.5, spotPaint);
    canvas.drawCircle(const Offset(5, 0), 3.8, spotPaint);
    canvas.drawCircle(const Offset(10, -9), 3.2, spotPaint);
  }

  void _drawStar(Canvas canvas) {
    final starPaint = Paint()..color = const Color(0xFFFFCA28);
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final r = i.isEven ? 24.0 : 11.0;
      final a = (i * math.pi / 5) - math.pi / 2;
      final pt = Offset(math.cos(a) * r, math.sin(a) * r);
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, starPaint);
  }

  void _drawHeart(Canvas canvas) {
    final heartPaint = Paint()..color = const Color(0xFFFF5252);
    final path = Path()
      ..moveTo(0, 16)
      ..cubicTo(-26, -2, -14, -24, 0, -8)
      ..cubicTo(14, -24, 26, -2, 0, 16)
      ..close();
    canvas.drawPath(path, heartPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!SoundtrackService.instance.visualEffectsEnabled) {
      return;
    }
    add(
      SequenceEffect([
        ScaleEffect.to(
          Vector2.all(1.45),
          EffectController(duration: 0.14, curve: Curves.easeOut),
        ),
        ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0.3, curve: Curves.elasticOut),
        ),
      ]),
    );
    onTapped();
  }
}
