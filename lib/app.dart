import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    '/': (context) => Login(),
    'home': (context) => Home()
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