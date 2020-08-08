import 'package:flutter/material.dart';
import 'screens/add_book/add_book_start_screen.dart';
import 'screens/checkout/book_tile_list_screen.dart';
import 'screens/checkout/checkout_form.dart'; 
import 'screens/checkout/checkout_screen.dart';
import 'screens/single_book/edit_single_book_library_screen.dart';
import 'screens/single_book/edit_single_book_screen.dart';
import 'screens/home_screen.dart';
import 'screens/libraries/add_library_screen.dart';
import 'screens/libraries/books_in_library_screen.dart';
import 'screens/libraries/libraries_screen.dart';
import 'screens/login_screen.dart';
import 'screens/shelves.dart';
import 'screens/single_book/single_book_screen.dart';
import 'screens/unpack/unpack_screen.dart';
import 'screens/unpack/checkbox_book_list.dart';

class App extends StatelessWidget {
  static final routes = {
    '/': (context) => Login(),
    'home': (context) => Home(),
    'unpack': (context) => UnpackScreen(),
    'addBook': (context) => AddBookScreen(),
    'libraries': (context) => LibrariesScreen(),
    'addLibrary': (context) => AddLibraryScreen(),
    'libraryBooks': (context) => LibraryBooksScreen(),
    SingleBookScreen.routeName: (context) => SingleBookScreen(),
    'editBook': (context) => EditBookScreen(),
    'editBookLibrary': (context) => EditLibraryScreen(),
    ShelvesScreen.routeName: (context) => ShelvesScreen(),
    CheckoutScreen.routeName: (context) => CheckoutScreen(),
    BooksTileListScreen.routeName: (context) => BooksTileListScreen(),
    'checkoutForm': (context) => CheckoutForm(),
    CheckoutBookListScreen.routeName: (context) => CheckoutBookListScreen()
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
