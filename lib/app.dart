import 'package:flutter/material.dart';
import 'screens/add_book/add_book_start_screen.dart';
import 'screens/add_library_screen.dart';
import 'screens/books_in_library_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/edit_single_book_screen.dart';
import 'screens/edit_single_book_library_screen.dart'; 
import 'screens/home_screen.dart';
import 'screens/libraries_screen.dart';
import 'screens/login_screen.dart';
import 'screens/shelves.dart';
import 'screens/single_book_screen.dart';
import 'screens/unpack_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    '/': (context) => Login(),
    'home': (context) => Home(),
    'unpack': (context) => UnpackScreen(),
    ShelvesScreen.routeName: (context) => ShelvesScreen(),
    'checkout': (context) => CheckoutScreen(),
    'addBook': (context) => AddBookScreen(),
    'libraries': (context) => LibrariesScreen(),
    'addLibrary': (context) => AddLibraryScreen(),
    'libraryBooks': (context) => LibraryBooksScreen(),
    SingleBookScreen.routeName: (context) => SingleBookScreen(),
    'editBook': (context) => EditBookScreen(),
    'editBookLibrary': (context) => EditLibraryScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BiblioFiles',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes);
  }
}
