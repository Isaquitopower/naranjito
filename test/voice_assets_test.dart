import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:naranjito/story/story_data.dart';
import 'package:naranjito/story/voice_narrator_service.dart';

void main() {
  test('All spoken utterances have non-empty pre-synthesized voice MP3 files', () {
    final checks = <({String text, double pitch, double rate})>[
      (
        text:
            '¡Hola amiguito! Toca un cuadrito con tus amigos para escuchar un cuento.',
        pitch: 1.2,
        rate: 0.46,
      ),
      (
        text:
            '¡Ese cuento se abrirá muy pronto! Toca el primer cuadrito con tus amigos para empezar.',
        pitch: 1.22,
        rate: 0.47,
      ),
    ];

    for (var storyIdx = 0; storyIdx <= 9; storyIdx++) {
      checks.add((
        text: getStoryCompletionVoice(storyIdx),
        pitch: 1.22,
        rate: 0.46,
      ));
      for (final scene in getStoryScenes(storyIdx)) {
        for (final beat in scene.beats) {
          checks.add((text: beat.text, pitch: beat.pitch, rate: beat.rate));
        }
        for (final char in scene.characters) {
          checks.add((
            text: char.spokenPhrase,
            pitch: char.voicePitch,
            rate: 0.46,
          ));
        }
        for (final prop in scene.props) {
          checks.add((text: prop.spokenSound, pitch: 1.25, rate: 0.46));
        }
      }
    }

    for (final item in checks) {
      final hash = VoiceNarratorService.hashUtterance(
        item.text,
        item.pitch,
        item.rate,
      );
      final file = File('assets/voices/$hash.mp3');
      expect(
        file.existsSync(),
        isTrue,
        reason: 'Missing voice file assets/voices/$hash.mp3 for "${item.text}"',
      );
      expect(
        file.lengthSync(),
        greaterThan(500),
        reason: 'Empty or corrupt voice file assets/voices/$hash.mp3',
      );
    }
  });
}
