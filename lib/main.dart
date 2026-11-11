import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'story/soundtrack_service.dart';
import 'story/story_flame_game.dart';
import 'story/story_screen.dart';
import 'story/voice_narrator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isMobile = !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);
  if (isMobile) {
    // Lock the entire app strictly to horizontal (landscape) orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Fullscreen immersive mode for kindergarten kids
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  runApp(const NaranjitoApp());
  unawaited(SoundtrackService.instance.init());
  unawaited(VoiceNarratorService.instance.init());
}

class NaranjitoApp extends StatelessWidget {
  const NaranjitoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naranjito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8F00),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class StoryCatalogItem {
  final int index;
  final bool isUnlocked;
  final Color accentColor;
  final IconData previewIcon;

  const StoryCatalogItem({
    required this.index,
    this.isUnlocked = false,
    required this.accentColor,
    required this.previewIcon,
  });
}

const List<StoryCatalogItem> _storiesCatalog = [
  StoryCatalogItem(
    index: 0,
    isUnlocked: true,
    accentColor: Color(0xFFFF6D00),
    previewIcon: Icons.edit_rounded,
  ),
  StoryCatalogItem(
    index: 1,
    isUnlocked: true,
    accentColor: Color(0xFF29B6F6),
    previewIcon: Icons.cloud_rounded,
  ),
  StoryCatalogItem(
    index: 2,
    isUnlocked: true,
    accentColor: Color(0xFFEC407A),
    previewIcon: Icons.bubble_chart_rounded,
  ),
  StoryCatalogItem(
    index: 3,
    isUnlocked: true,
    accentColor: Color(0xFF43A047),
    previewIcon: Icons.park_rounded,
  ),
  StoryCatalogItem(
    index: 4,
    isUnlocked: true,
    accentColor: Color(0xFFFFB300),
    previewIcon: Icons.star_rounded,
  ),
  StoryCatalogItem(
    index: 5,
    isUnlocked: true,
    accentColor: Color(0xFF7E57C2),
    previewIcon: Icons.sports_handball_rounded,
  ),
  StoryCatalogItem(
    index: 6,
    isUnlocked: true,
    accentColor: Color(0xFF26A69A),
    previewIcon: Icons.extension_rounded,
  ),
  StoryCatalogItem(
    index: 7,
    isUnlocked: true,
    accentColor: Color(0xFFEF5350),
    previewIcon: Icons.directions_car_filled_rounded,
  ),
  StoryCatalogItem(
    index: 8,
    isUnlocked: true,
    accentColor: Color(0xFFAB47BC),
    previewIcon: Icons.pan_tool_rounded,
  ),
  StoryCatalogItem(
    index: 9,
    isUnlocked: true,
    accentColor: Color(0xFF66BB6A),
    previewIcon: Icons.shield_rounded,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SoundtrackService.instance.playHomeMusic();
      VoiceNarratorService.instance.speak(
        '¡Hola amiguito! Toca un cuadrito con tus amigos para escuchar un cuento.',
        pitch: 1.2,
        rate: 0.46,
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openStory(StoryCatalogItem item) async {
    if (item.isUnlocked) {
      VoiceNarratorService.instance.stop();
      StoryFlameGame.preloadStoryAssets(
        item.index,
        firstSceneOnly: true,
      );
      if (!mounted) return;
      await Navigator.of(context).push(
        PageRouteBuilder<void>(
          transitionDuration: const Duration(milliseconds: 320),
          pageBuilder: (context, animation, secondaryAnimation) =>
              StoryReaderScreen(storyIndex: item.index),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                ),
                child: child,
              ),
            );
          },
        ),
      );
      if (mounted) {
        SoundtrackService.instance.playHomeMusic();
      }
    } else {
      VoiceNarratorService.instance.speak(
        '¡Ese cuento se abrirá muy pronto! Toca el primer cuadrito con tus amigos para empezar.',
        pitch: 1.22,
        rate: 0.47,
      );
    }
  }

  void _showSettingsModal() {
    showAppSettingsDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    // Portada.jpg dimensions: 2912 x 1440 (Horizontal)
    // Using FittedBox(fit: BoxFit.fill) inside SizedBox.expand so Portada.jpg fills 100% of the screen width and height with NO extra side bars
    const double designWidth = 2912;
    const double designHeight = 1440;

    return Scaffold(
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.fill,
          child: SizedBox(
            width: designWidth,
            height: designHeight,
            child: Stack(
              children: [
                // 1. Full background image Portada.jpg filling the entire screen without side bars
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background/Portada.jpg',
                    fit: BoxFit.fill,
                    cacheWidth: 1920,
                    filterQuality: FilterQuality.low,
                    gaplessPlayback: true,
                  ),
                ),

                // 2. Interactive Grid aligned with the 10 white frames on Portada.jpg
                Positioned(
                  left: designWidth * 0.145,
                  right: designWidth * 0.128,
                  top: designHeight * 0.275,
                  bottom: designHeight * 0.118,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: List.generate(5, (col) {
                            final item = _storiesCatalog[col];
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                                child: _PortadaStorySlot(
                                  item: item,
                                  pulseAnimation: _pulseController,
                                  onTap: () => _openStory(item),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: Row(
                          children: List.generate(5, (col) {
                            final item = _storiesCatalog[col + 5];
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                                child: _PortadaStorySlot(
                                  item: item,
                                  pulseAnimation: _pulseController,
                                  onTap: () => _openStory(item),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // 3. Interactive hotspot over the bottom-left gear button in Portada.jpg
                Positioned(
                  left: designWidth * 0.008,
                  bottom: designHeight * 0.032,
                  width: designWidth * 0.065,
                  height: designHeight * 0.13,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _showSettingsModal,
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

class _PortadaStorySlot extends StatelessWidget {
  final StoryCatalogItem item;
  final Animation<double> pulseAnimation;
  final VoidCallback onTap;

  const _PortadaStorySlot({
    required this.item,
    required this.pulseAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (item.isUnlocked) {
      final borderColor = switch (item.index) {
        9 => const Color(0xFF66BB6A),
        8 => const Color(0xFFAB47BC),
        7 => const Color(0xFFEF5350),
        6 => const Color(0xFF26A69A),
        5 => const Color(0xFF7E57C2),
        4 => const Color(0xFFFFB300),
        3 => const Color(0xFF43A047),
        2 => const Color(0xFFEC407A),
        1 => const Color(0xFF29B6F6),
        _ => const Color(0xFFFF8F00),
      };
      final playButtonColor = switch (item.index) {
        9 => const Color(0xFF388E3C),
        8 => const Color(0xFF8E24AA),
        7 => const Color(0xFFD32F2F),
        6 => const Color(0xFF00897B),
        5 => const Color(0xFF5E35B1),
        4 => const Color(0xFFF57C00),
        3 => const Color(0xFF2E7D32),
        2 => const Color(0xFFD81B60),
        1 => const Color(0xFF0288D1),
        _ => const Color(0xFFFF6D00),
      };
      final coverAsset = switch (item.index) {
        9 => 'assets/images/portadas/parque.jpg',
        8 => 'assets/images/portadas/cosquillas.jpg',
        7 => 'assets/images/portadas/carrito.jpg',
        6 => 'assets/images/portadas/pieza.jpg',
        5 => 'assets/images/portadas/juegos.jpg',
        4 => 'assets/images/portadas/companera.jpg',
        3 => 'assets/images/portadas/papalote.jpg',
        2 => 'assets/images/portadas/burbuja.jpg',
        1 => 'assets/images/portadas/nube.jpg',
        _ => 'assets/images/portadas/crayon.jpg',
      };

      return AnimatedBuilder(
        animation: pulseAnimation,
        builder: (context, child) {
          final scale = 1.0 + (pulseAnimation.value * 0.04);
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(48),
            child: Container(
              margin: const EdgeInsets.all(14),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44),
                border: Border.all(
                  color: borderColor,
                  width: 8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: borderColor.withValues(alpha: 0.45),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  // Story cover illustration from assets/images/portadas/
                  Image.asset(
                    coverAsset,
                    fit: BoxFit.cover,
                    cacheWidth: 512,
                    filterQuality: FilterQuality.low,
                    gaplessPlayback: true,
                  ),

                  // Big friendly Play icon button in the bottom-right corner
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: playButtonColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 58,
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

    // Locked / Upcoming Story Slot inside the Portada frame (Pure icons, zero text)
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(48),
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: item.accentColor.withValues(alpha: 0.12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: item.accentColor.withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: item.accentColor.withValues(alpha: 0.50),
                    width: 5,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.previewIcon,
                  size: 60,
                  color: item.accentColor.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 18),
              Icon(
                Icons.lock_rounded,
                size: 42,
                color: Colors.brown.withValues(alpha: 0.40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
