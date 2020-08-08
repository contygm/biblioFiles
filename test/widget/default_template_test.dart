import 'package:biblioFiles/templates/default_template.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  Widget setUpApp() {
    return MaterialApp(
        title: 'BiblioFiles',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTemplate(
          floatingAction: FloatingActionButton(
              key: Key('FAB'), child: Icon(Icons.add), onPressed: () => {}),
          floatingActionLocation: FloatingActionButtonLocation.centerDocked,
          content: Text('TEST CONTENT'),
        ));
  }

  testWidgets('AppBar Layout', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(setUpApp());

    expect(find.text('BiblioFiles'), findsOneWidget); // Appbar and title
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
