import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ngo/main.dart' show NGOConnectApp; // Only import the app, not the main()

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build only the widget, do not run full main()
    await tester.pumpWidget(const NGOConnectApp());

    // Since your app likely does not have a counter by default,
    // comment/remove the default counter assertions or adjust them
    // Example: if your home screen is OnboardingScreen, check for its text
    expect(find.text('Get Started'), findsOneWidget); // adjust to your onboarding text
  });
}
