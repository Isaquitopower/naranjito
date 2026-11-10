import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceNarratorService {
  VoiceNarratorService._();
  static final VoiceNarratorService instance = VoiceNarratorService._();

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;
  double _volume = 1.0;
  VoidCallback? _onCompleteCallback;

  double get volume => _volume;

  Future<void> init() async {
    if (_initialized) return;
    try {
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        ],
        IosTextToSpeechAudioMode.defaultMode,
      );
      await _tts.setLanguage('es-MX');
      await _tts.setSpeechRate(0.46); // Calm, clear pace for kindergarten kids
      await _tts.setPitch(1.15); // Warm, friendly storyteller tone
      await _tts.setVolume(_volume);
      await _tts.awaitSpeakCompletion(true);

      _tts.setCompletionHandler(() {
        final cb = _onCompleteCallback;
        _onCompleteCallback = null;
        cb?.call();
      });
      _initialized = true;
    } catch (_) {
      // Fallback if TTS is unavailable in unit tests or unsupported platform
      _initialized = true;
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
    _onCompleteCallback = onDone;
    try {
      await _tts.stop();
      await _tts.setVolume(_volume);
      await _tts.setPitch(pitch);
      await _tts.setSpeechRate(rate);
      await _tts.speak(text);
    } catch (_) {
      onDone?.call();
    }
  }

  Future<void> stop() async {
    _onCompleteCallback = null;
    try {
      await _tts.stop();
    } catch (_) {}
  }
}
