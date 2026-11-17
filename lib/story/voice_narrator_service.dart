import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceNarratorService {
  VoiceNarratorService._();
  static final VoiceNarratorService instance = VoiceNarratorService._();

  static String hashUtterance(String text, double pitch, double rate) {
    final key =
        '${text.trim()}|${pitch.toStringAsFixed(2)}|${rate.toStringAsFixed(2)}';
    var hash = 0x811c9dc5;
    for (var i = 0; i < key.length; i++) {
      hash ^= key.codeUnitAt(i);
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return 'v_${hash.toRadixString(16).padLeft(8, '0')}';
  }

  final AudioPlayer _voicePlayer = AudioPlayer();
  final FlutterTts _tts = FlutterTts();

  bool _initialized = false;
  bool _ttsInitialized = false;
  bool _playingPreSynthesized = false;
  bool _isTtsSpeaking = false;
  bool _isPaused = false;
  double _volume = 1.0;

  VoidCallback? _onCompleteCallback;
  Timer? _fallbackTimer;

  int _speechSessionId = 0;
  int _currentTextLength = 0;
  int _currentDurationMs = 0;
  int _lastPositionMs = 0;
  double _pendingSeekFraction = 0.0;

  // Real-time speech progress tracking
  void Function(int offset)? onSpeechProgress;
  int _lastSpokenWordIndex = 0;
  int _currentBaseOffset = 0;

  double get volume => _volume;
  int get lastSpokenWordIndex => _currentBaseOffset + _lastSpokenWordIndex;

  bool get _isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  void _resetFallbackTimer(int milliseconds) {
    _fallbackTimer?.cancel();
    _fallbackTimer = Timer(
      Duration(milliseconds: milliseconds),
      _completePendingSpeech,
    );
  }

  void _completePendingSpeech() {
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _playingPreSynthesized = false;
    _isTtsSpeaking = false;
    _isPaused = false;
    final cb = _onCompleteCallback;
    _onCompleteCallback = null;
    cb?.call();
  }

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      await _voicePlayer.setReleaseMode(ReleaseMode.stop);
      _voicePlayer.onDurationChanged.listen((dur) {
        if (!_playingPreSynthesized || dur.inMilliseconds <= 0) return;
        _currentDurationMs = dur.inMilliseconds;
        if (_pendingSeekFraction > 0.001) {
          final frac = _pendingSeekFraction;
          _pendingSeekFraction = 0.0;
          final seekMs = (dur.inMilliseconds * frac)
              .round()
              .clamp(0, (dur.inMilliseconds - 50).clamp(0, dur.inMilliseconds));
          _lastPositionMs = seekMs;
          unawaited(_voicePlayer.seek(Duration(milliseconds: seekMs)));
        }
        if (!_isPaused) {
          final remaining =
              (dur.inMilliseconds - _lastPositionMs).clamp(500, 30000);
          _resetFallbackTimer(remaining + 3000);
        }
      });
      _voicePlayer.onPositionChanged.listen((pos) {
        if (!_playingPreSynthesized || _isPaused) return;
        _lastPositionMs = pos.inMilliseconds;
        if (_currentDurationMs > 0 && _currentTextLength > 0) {
          final frac =
              (pos.inMilliseconds / _currentDurationMs).clamp(0.0, 1.0);
          final offset =
              (frac * _currentTextLength).round().clamp(0, _currentTextLength);
          _lastSpokenWordIndex = offset;
          onSpeechProgress?.call(offset);
        }
      });
      _voicePlayer.onPlayerComplete.listen((_) {
        if (_playingPreSynthesized && !_isPaused) {
          _completePendingSpeech();
        }
      });
    } catch (_) {
      // Fallback if AudioPlayer is unavailable (e.g. unit tests)
    }
  }

  Future<void> _ensureTtsInitialized() async {
    if (_ttsInitialized) return;
    _ttsInitialized = true;
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

      var langSet = await _tts.setLanguage('es-MX');
      if (langSet != 1) {
        langSet = await _tts.setLanguage('es-ES');
      }
      if (langSet != 1) {
        await _tts.setLanguage('es');
      }

      if (_isWindows) {
        try {
          final voices = await _tts.getVoices;
          if (voices is List && voices.isNotEmpty) {
            dynamic bestVoice;
            for (final v in voices) {
              if (v is Map) {
                final locale = (v['locale'] ?? '').toString().toLowerCase();
                final name = (v['name'] ?? '').toString().toLowerCase();
                if (locale.contains('es-mx') ||
                    locale.contains('es_mx') ||
                    name.contains('mexico') ||
                    name.contains('sabina') ||
                    name.contains('raul') ||
                    name.contains('dalia')) {
                  bestVoice = v;
                  break;
                }
                if (bestVoice == null &&
                    (locale.startsWith('es') ||
                        name.contains('spanish') ||
                        name.contains('español') ||
                        name.contains('helena') ||
                        name.contains('laura') ||
                        name.contains('pablo'))) {
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

      await _tts.setSpeechRate(0.46);
      await _tts.setPitch(1.15);
      await _tts.setVolume(_volume);
      if (!_isWindows) {
        await _tts.awaitSpeakCompletion(true);
      }

      _tts.setCompletionHandler(_completePendingSpeech);
      _tts.setErrorHandler((_) => _completePendingSpeech());
      _tts.setProgressHandler(
          (String text, int startOffset, int endOffset, String word) {
        _lastSpokenWordIndex = startOffset;
        onSpeechProgress?.call(_currentBaseOffset + startOffset);
      });
    } catch (_) {}
  }

  Future<void> setVolume(double newVolume) async {
    _volume = newVolume.clamp(0.0, 1.0);
    try {
      await _voicePlayer.setVolume(_volume);
    } catch (_) {}
    if (_ttsInitialized) {
      try {
        await _tts.setVolume(_volume);
      } catch (_) {}
    }
  }

  Future<void> speak(
    String text, {
    double pitch = 1.15,
    double rate = 0.46,
    int startCharOffset = 0,
    VoidCallback? onDone,
  }) async {
    await init();
    final sessionId = ++_speechSessionId;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _isPaused = false;
    final wasTts = _isTtsSpeaking;
    _playingPreSynthesized = false;
    _isTtsSpeaking = false;
    _onCompleteCallback = null;

    try {
      await _voicePlayer.stop();
    } catch (_) {}
    if (sessionId != _speechSessionId) return;

    if (wasTts) {
      try {
        await _tts.stop();
      } catch (_) {}
      if (sessionId != _speechSessionId) return;
    }

    _onCompleteCallback = onDone;
    _currentTextLength = text.length;
    _currentDurationMs = 0;
    _lastPositionMs = 0;
    _currentBaseOffset = 0;
    _lastSpokenWordIndex = startCharOffset.clamp(0, text.length);
    _pendingSeekFraction = (startCharOffset > 0 && text.isNotEmpty)
        ? (startCharOffset / text.length).clamp(0.0, 0.96)
        : 0.0;

    final hash = hashUtterance(text, pitch, rate);
    final assetPath = 'voices/$hash.mp3';

    final remainingFraction = 1.0 - _pendingSeekFraction;
    final safetyMs =
        ((text.length * 90 * remainingFraction).round() + 3500).clamp(3000, 22000);
    _resetFallbackTimer(safetyMs);

    try {
      _playingPreSynthesized = true;
      await _voicePlayer.setVolume(_volume);
      await _voicePlayer.play(AssetSource(assetPath));
      if (sessionId != _speechSessionId) return;
      if (_isPaused) {
        await _voicePlayer.pause();
        return;
      }

      if (_currentDurationMs == 0) {
        final d = await _voicePlayer.getDuration();
        if (sessionId != _speechSessionId) return;
        if (d != null && d.inMilliseconds > 0) {
          _currentDurationMs = d.inMilliseconds;
          if (_pendingSeekFraction > 0.001) {
            final frac = _pendingSeekFraction;
            _pendingSeekFraction = 0.0;
            final seekMs = (d.inMilliseconds * frac)
                .round()
                .clamp(0, (d.inMilliseconds - 50).clamp(0, d.inMilliseconds));
            _lastPositionMs = seekMs;
            await _voicePlayer.seek(Duration(milliseconds: seekMs));
          }
          if (!_isPaused) {
            final remaining =
                (d.inMilliseconds - _lastPositionMs).clamp(500, 30000);
            _resetFallbackTimer(remaining + 3000);
          }
        }
      }
      return;
    } catch (_) {
      if (sessionId != _speechSessionId) return;
      _playingPreSynthesized = false;
    }

    // Fallback to native TTS if pre-synthesized asset is unavailable (e.g., tests)
    await _speakWithTtsFallback(
      text,
      pitch: pitch,
      rate: rate,
      startCharOffset: startCharOffset,
      sessionId: sessionId,
    );
  }

  Future<void> _speakWithTtsFallback(
    String text, {
    required double pitch,
    required double rate,
    required int startCharOffset,
    required int sessionId,
  }) async {
    await _ensureTtsInitialized();
    if (sessionId != _speechSessionId) return;

    if (_volume <= 0.001) {
      final estimatedMs = (text.length * 60).clamp(1500, 8000);
      _resetFallbackTimer(estimatedMs);
      return;
    }

    _currentBaseOffset = startCharOffset;
    _lastSpokenWordIndex = 0;

    final textToSpeak = (startCharOffset > 0 && startCharOffset < text.length)
        ? text.substring(startCharOffset).trimLeft()
        : text;

    final estimatedMs = (textToSpeak.length * 75).clamp(2000, 14000);
    _resetFallbackTimer(estimatedMs);

    try {
      if (!_isWindows || _isTtsSpeaking) {
        await _tts.stop();
      }
      if (sessionId != _speechSessionId) return;
      _isTtsSpeaking = true;
      await _tts.setVolume(_volume);
      await _tts.setPitch(pitch);
      await _tts.setSpeechRate(rate);
      await _tts.speak(textToSpeak);
    } catch (_) {
      _completePendingSpeech();
    }
  }

  /// Pauses narration at the exact current millisecond without dropping completion callback.
  Future<void> pause() async {
    if (_isPaused) return;
    _isPaused = true;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    if (_playingPreSynthesized) {
      try {
        final pos = await _voicePlayer.getCurrentPosition();
        if (pos != null && _currentDurationMs > 0 && _currentTextLength > 0) {
          _lastPositionMs = pos.inMilliseconds;
          final frac =
              (pos.inMilliseconds / _currentDurationMs).clamp(0.0, 1.0);
          _lastSpokenWordIndex =
              (frac * _currentTextLength).round().clamp(0, _currentTextLength);
        }
        await _voicePlayer.pause();
      } catch (_) {}
    } else if (_isTtsSpeaking) {
      _isTtsSpeaking = false;
      try {
        await _tts.stop();
      } catch (_) {}
    }
  }

  /// Resumes pre-synthesized narration from the exact millisecond it was paused.
  Future<void> resume() async {
    if (!_isPaused) return;
    _isPaused = false;
    if (_playingPreSynthesized) {
      try {
        final remaining = _currentDurationMs > 0
            ? (_currentDurationMs - _lastPositionMs).clamp(500, 30000)
            : 8000;
        _resetFallbackTimer(remaining + 3000);
        await _voicePlayer.setVolume(_volume);
        await _voicePlayer.resume();
      } catch (_) {
        _completePendingSpeech();
      }
    }
  }

  Future<void> stop() async {
    _speechSessionId++;
    _currentBaseOffset = 0;
    _lastSpokenWordIndex = 0;
    _currentTextLength = 0;
    _currentDurationMs = 0;
    _lastPositionMs = 0;
    _pendingSeekFraction = 0.0;
    _isPaused = false;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    _onCompleteCallback = null;
    final wasPre = _playingPreSynthesized;
    final wasTts = _isTtsSpeaking;
    _playingPreSynthesized = false;
    _isTtsSpeaking = false;
    if (wasPre) {
      try {
        await _voicePlayer.stop();
      } catch (_) {}
    }
    if (_ttsInitialized && (!_isWindows || wasTts)) {
      try {
        await _tts.stop();
      } catch (_) {}
    }
  }
}
