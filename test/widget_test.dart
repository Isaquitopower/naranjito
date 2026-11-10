import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naranjito/main.dart';

void main() {
  testWidgets('Home screen renders purely visual story grid without text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NaranjitoApp());
    expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(10));
    expect(find.byType(Text), findsNothing);
  });
}
