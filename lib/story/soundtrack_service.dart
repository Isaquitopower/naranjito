import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'voice_narrator_service.dart';

class SoundtrackService extends ChangeNotifier with WidgetsBindingObserver {
  SoundtrackService._();
  static final SoundtrackService instance = SoundtrackService._();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _initialized = false;
  bool _isAppInForeground = true;
  String? _currentAssetPath;

  double _musicVolume = 0.35;
  double _narrationVolume = 1.0;
  bool _visualEffectsEnabled = true;

  double get musicVolume => _musicVolume;
  double get narrationVolume => _narrationVolume;
  bool get visualEffectsEnabled => _visualEffectsEnabled;

  static const String homeTrack = 'soundtrack/Inicio.mp3';

  static String storyTrackForIndex(int storyIndex) {
    return switch (storyIndex) {
      9 => 'soundtrack/parque.mp3',
      8 => 'soundtrack/cosquillas.mp3',
      7 => 'soundtrack/carrito.mp3',
      6 => 'soundtrack/pieza.mp3',
      5 => 'soundtrack/juegos.mp3',
      4 => 'soundtrack/companera.mp3',
      3 => 'soundtrack/papalote.mp3',
      2 => 'soundtrack/burbuja.mp3',
      1 => 'soundtrack/nube.mp3',
      _ => 'soundtrack/crayon.mp3',
    };
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);
    try {
      final isMobile = !kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS);
      if (isMobile) {
        await AudioPlayer.global.setAudioContext(
          AudioContext(
            iOS: AudioContextIOS(
              category: AVAudioSessionCategory.playback,
              options: const {AVAudioSessionOptions.mixWithOthers},
            ),
            android: const AudioContextAndroid(
              isSpeakerphoneOn: true,
              stayAwake: false,
              contentType: AndroidContentType.music,
              usageType: AndroidUsageType.media,
              audioFocus: AndroidAudioFocus.none,
            ),
          ),
        );
      }
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _isAppInForeground = true;
        _resumeIfActive();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _isAppInForeground = false;
        _pauseForBackground();
    }
  }

  Future<void> _pauseForBackground() async {
    try {
      await _bgmPlayer.pause();
    } catch (_) {}
    await VoiceNarratorService.instance.stop();
  }

  Future<void> _resumeIfActive() async {
    if (_currentAssetPath == null) return;
    try {
      await _bgmPlayer.setVolume(_musicVolume);
      await _bgmPlayer.resume();
    } catch (_) {}
  }

  Future<void> playHomeMusic() async {
    await _playTrack(homeTrack);
  }

  Future<void> playStoryMusic(int storyIndex) async {
    final track = storyTrackForIndex(storyIndex);
    await _playTrack(track);
  }

  Future<void> _playTrack(String assetPath) async {
    await init();
    try {
      if (_currentAssetPath == assetPath &&
          _bgmPlayer.state == PlayerState.playing) {
        await _bgmPlayer.setVolume(_musicVolume);
        return;
      }
      _currentAssetPath = assetPath;
      if (!_isAppInForeground) return;
      await _bgmPlayer.stop();
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(_musicVolume);
      await _bgmPlayer.play(AssetSource(assetPath));
    } catch (_) {}
  }

  Future<void> setMusicVolume(double value) async {
    _musicVolume = value.clamp(0.0, 1.0);
    notifyListeners();
    try {
      // Direct linear mapping: volume 0.0 is completely silent, 1.0 is full volume
      await _bgmPlayer.setVolume(_musicVolume);
    } catch (_) {}
  }

  Future<void> setNarrationVolume(double value) async {
    _narrationVolume = value.clamp(0.0, 1.0);
    notifyListeners();
    await VoiceNarratorService.instance.setVolume(_narrationVolume);
  }

  void setVisualEffectsEnabled(bool enabled) {
    if (_visualEffectsEnabled == enabled) return;
    _visualEffectsEnabled = enabled;
    notifyListeners();
  }
}

void showAppSettingsDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) {
      return const _AppSettingsDialog();
    },
  );
}

class _AppSettingsDialog extends StatelessWidget {
  const _AppSettingsDialog();

  @override
  Widget build(BuildContext context) {
    final service = SoundtrackService.instance;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListenableBuilder(
        listenable: service,
        builder: (context, _) {
          final narrationVol = service.narrationVolume;
          final musicVol = service.musicVolume;
          final effectsOn = service.visualEffectsEnabled;

          return Container(
            constraints: const BoxConstraints(maxWidth: 540),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF7),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: const Color(0xFFFF9800), width: 6),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF3E0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.settings_rounded,
                          color: Color(0xFFFF6D00),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Configuración',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4E342E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 1. Narration Volume Slider
                  _VolumeControlCard(
                    icon: narrationVol > 0.01
                        ? Icons.record_voice_over_rounded
                        : Icons.voice_over_off_rounded,
                    accentColor: const Color(0xFFFF8F00),
                    label: 'Narración',
                    value: narrationVol,
                    onChanged: (val) => service.setNarrationVolume(val),
                    onToggleMute: () {
                      service.setNarrationVolume(
                        narrationVol > 0.01 ? 0.0 : 1.0,
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // 2. Background Music (Songs) Volume Slider
                  _VolumeControlCard(
                    icon: musicVol > 0.01
                        ? Icons.music_note_rounded
                        : Icons.music_off_rounded,
                    accentColor: const Color(0xFF29B6F6),
                    label: 'Canciones',
                    value: musicVol,
                    onChanged: (val) => service.setMusicVolume(val),
                    onToggleMute: () {
                      service.setMusicVolume(
                        musicVol > 0.01 ? 0.0 : 0.35,
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // 3. Visual Effects (Interactive Icons in Stories) Toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAB47BC).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFFAB47BC).withValues(alpha: 0.45),
                        width: 2.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: effectsOn
                                ? const Color(0xFFAB47BC)
                                : Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.touch_app_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Efectos visuales',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF4E342E),
                                ),
                              ),
                              Text(
                                'Iconos interactivos dentro de los cuentos',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          value: effectsOn,
                          activeTrackColor: const Color(0xFF43A047),
                          onChanged: (val) =>
                              service.setVisualEffectsEnabled(val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Close / Confirm Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      customBorder: const CircleBorder(),
                      child: Ink(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFF43A047),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VolumeControlCard extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onToggleMute;

  const _VolumeControlCard({
    required this.icon,
    required this.accentColor,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onToggleMute,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.45),
          width: 2.5,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onToggleMute,
            customBorder: const CircleBorder(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: value > 0.01 ? accentColor : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4E342E),
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: accentColor,
                inactiveTrackColor: accentColor.withValues(alpha: 0.25),
                thumbColor: accentColor,
                overlayColor: accentColor.withValues(alpha: 0.18),
                trackHeight: 8,
              ),
              child: Slider(
                value: value,
                min: 0.0,
                max: 1.0,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

