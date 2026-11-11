import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceNarratorService {
  VoiceNarratorService._();
  static final VoiceNarratorService instance = VoiceNarratorService._();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;
  bool _isCurrentlySpeaking = false;
  double _volume = 1.0;
  VoidCallback? _onCompleteCallback;
  Timer? _fallbackTimer;

  double get volume => _volume;

  bool get _isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  void _completePendingSpeech() {
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _isCurrentlySpeaking = false;
    final cb = _onCompleteCallback;
    _onCompleteCallback = null;
    cb?.call();
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
        await _tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
            IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
          ],
          IosTextToSpeechAudioMode.defaultMode,
        );
      }
      await _tts.setLanguage('es-MX');
      await _tts.setSpeechRate(0.46); // Calm, clear pace for kindergarten kids
      await _tts.setPitch(1.15); // Warm, friendly storyteller tone
      await _tts.setVolume(_volume);
      if (!_isWindows) {
        await _tts.awaitSpeakCompletion(true);
      }

      _tts.setCompletionHandler(_completePendingSpeech);
      _tts.setErrorHandler((_) => _completePendingSpeech());
    } catch (_) {
      // Fallback if TTS is unavailable in unit tests or unsupported platform
    }
  }

  Future<void> setVolume(double newVolume) async {
    _volume = newVolume.clamp(0.0, 1.0);
    try {
      await _tts.setVolume(_volume);
    } catch (_) {}
  }

  Future<void> speak(
    String text, {
    double pitch = 1.15,
    double rate = 0.46,
    VoidCallback? onDone,
  }) async {
    await init();
    _fallbackTimer?.cancel();
    _onCompleteCallback = onDone;

    // Safety timer on Windows (or if TTS audio device is unavailable) so story beats never hang
    final estimatedMs = (text.length * 75).clamp(2000, 14000);
    _fallbackTimer = Timer(
      Duration(milliseconds: estimatedMs),
      _completePendingSpeech,
    );

    try {
      if (!_isWindows || _isCurrentlySpeaking) {
        await _tts.stop();
      }
      _isCurrentlySpeaking = true;
      await _tts.setVolume(_volume);
      await _tts.setPitch(pitch);
      await _tts.setSpeechRate(rate);
      await _tts.speak(text);
    } catch (_) {
      _completePendingSpeech();
    }
  }

  Future<void> stop() async {
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _onCompleteCallback = null;
    final wasSpeaking = _isCurrentlySpeaking;
    _isCurrentlySpeaking = false;
    try {
      if (!_isWindows || wasSpeaking) {
        await _tts.stop();
      }
    } catch (_) {}
  }
}
