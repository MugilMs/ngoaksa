import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
