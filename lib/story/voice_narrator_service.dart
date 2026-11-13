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

  // Real-time speech progress tracking
  void Function(int offset)? onSpeechProgress;
  int _lastSpokenWordIndex = 0;
  int _currentBaseOffset = 0;

  double get volume => _volume;
  int get lastSpokenWordIndex => _currentBaseOffset + _lastSpokenWordIndex;

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

      // Best effort language matching across platforms (es-MX first, then es)
      var langSet = await _tts.setLanguage('es-MX');
      if (langSet != 1) {
        langSet = await _tts.setLanguage('es-ES');
      }
      if (langSet != 1) {
        await _tts.setLanguage('es');
      }

      // On Windows / Desktop, search available voices to find Mexican or Spanish voices
      if (_isWindows) {
        try {
          final voices = await _tts.getVoices;
          if (voices is List && voices.isNotEmpty) {
            dynamic bestVoice;
            for (final v in voices) {
              if (v is Map) {
                final locale = (v['locale'] ?? '').toString().toLowerCase();
                final name = (v['name'] ?? '').toString().toLowerCase();
                // Priority 1: es-mx / Sabina / Raul / Dalia / Jorge
                if (locale.contains('es-mx') || locale.contains('es_mx') || name.contains('mexico') || name.contains('sabina') || name.contains('raul') || name.contains('dalia')) {
                  bestVoice = v;
                  break;
                }
                // Priority 2: any Spanish voice (es-es, es-us, Helena, Laura, Pablo, etc.)
                if (bestVoice == null && (locale.startsWith('es') || name.contains('spanish') || name.contains('español') || name.contains('helena') || name.contains('laura') || name.contains('pablo'))) {
                  bestVoice = v;
                }
              }
            }
            if (bestVoice != null && bestVoice is Map) {
              final voiceMap = <String, String>{
                'name': bestVoice['name']?.toString() ?? '',
                'locale': bestVoice['locale']?.toString() ?? '',
              };
              await _tts.setVoice(voiceMap);
            }
          }
        } catch (_) {}
      }

      await _tts.setSpeechRate(0.46); // Calm, clear pace for kindergarten kids
      await _tts.setPitch(1.15); // Warm, friendly storyteller tone
      await _tts.setVolume(_volume);
      if (!_isWindows) {
        await _tts.awaitSpeakCompletion(true);
      }

      _tts.setCompletionHandler(_completePendingSpeech);
      _tts.setErrorHandler((_) => _completePendingSpeech());
      _tts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
        _lastSpokenWordIndex = startOffset;
        onSpeechProgress?.call(_currentBaseOffset + startOffset);
      });
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
    int startCharOffset = 0,
    VoidCallback? onDone,
  }) async {
    await init();
    _fallbackTimer?.cancel();
    _onCompleteCallback = onDone;

    // If volume is muted (0.0), do not play voice audio, finish immediately
    if (_volume <= 0.001) {
      final estimatedMs = (text.length * 60).clamp(1500, 8000);
      _fallbackTimer = Timer(
        Duration(milliseconds: estimatedMs),
        _completePendingSpeech,
      );
      return;
    }

    _currentBaseOffset = startCharOffset;
    _lastSpokenWordIndex = 0;

    // Slice text from the exact character offset if resuming mid-sentence
    final textToSpeak = (startCharOffset > 0 && startCharOffset < text.length)
        ? text.substring(startCharOffset).trimLeft()
        : text;

    // Safety timer on Windows (or if TTS audio device is unavailable) so story beats never hang
    final estimatedMs = (textToSpeak.length * 75).clamp(2000, 14000);
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
      await _tts.speak(textToSpeak);
    } catch (_) {
      _completePendingSpeech();
    }
  }

  /// Pauses and returns the exact character offset where narration was paused
  int pauseNarration() {
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _onCompleteCallback = null;
    _isCurrentlySpeaking = false;
    try {
      _tts.stop();
    } catch (_) {}
    return _currentBaseOffset + _lastSpokenWordIndex;
  }

  Future<void> stop() async {
    _currentBaseOffset = 0;
    _lastSpokenWordIndex = 0;
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
