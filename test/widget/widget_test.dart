// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:biblioFiles/main.dart';

void main() {
  testWidgets('Basic Login smoke test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    expect(find.text('Google Sign in'), findsOneWidget);
    expect(find.text('No one has signed in.'), findsNothing);

    await tester.tap(find.text('Sign out'));
    await tester.pump();

    expect(find.text('Google Sign in'), findsOneWidget);
    expect(find.text('No one has signed in.'), findsOneWidget);
  });
}
