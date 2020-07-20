import 'package:flutter/material.dart';
import 'screens/add_book_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/home_screen.dart';
import 'screens/libraries_screen.dart';
import 'screens/login_screen.dart';
import 'screens/shelves.dart';
import 'screens/unpack_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    '/': (context) => Login(),
    'home': (context) => Home(),
    'unpack': (context) => UnpackScreen(),
    'shelves': (context) => ShelvesScreen(),
    'checkout': (context) => CheckoutScreen(),
    'addBook': (context) => AddBookScreen(),
    'libraries': (context) => LibrariesScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BiblioFiles',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes
    );
  }
}