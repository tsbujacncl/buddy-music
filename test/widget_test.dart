// Basic widget test for Buddy app

import 'package:flutter_test/flutter_test.dart';
import 'package:buddy/main.dart';

void main() {
  testWidgets('Buddy app launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BuddyApp());

    // Verify that Buddy welcome text appears
    expect(find.text('Welcome to Buddy'), findsOneWidget);

    // Verify bottom navigation is present
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
