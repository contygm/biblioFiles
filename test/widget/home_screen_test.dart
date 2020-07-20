import 'package:biblioFiles/screens/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Basic Home layout', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'BiblioFiles',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    ));

    expect(find.text('Shelves'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.leanpub), findsOneWidget);
    
    expect(find.text('Checkout'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.tasks), findsOneWidget);
    
    expect(find.text('Libraries'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.clone), findsOneWidget);
    
    expect(find.text('Unpack'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.boxOpen), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);
    
    expect(find.text('BiblioFiles'), findsOneWidget); // Appbar
  });
}
