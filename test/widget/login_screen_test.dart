import 'package:biblioFiles/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  testWidgets('Basic Login layout', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'BiblioFiles',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login()
    ));

    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('BiblioFiles'), findsNWidgets(2)); // Appbar and title
    expect(find.byIcon(FontAwesomeIcons.bookReader), findsOneWidget);

  });
}
