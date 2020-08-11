import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/home_tile.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import '../libraries/add_library_screen.dart';
import 'add_book_error_screen.dart';
import 'book_to_add_details_screen.dart';
import 'isbn_entry_screen.dart';
import 'manual_book_entry_screen.dart';

class AddBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: AddBook());
  }
}

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: libraryCount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data > 0) {
            return Visibility(
              visible: _isVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text('How do you want to add your Book?', 
                      style: Styles.header2DarkGreenStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HomeTile(
                    title: 'Scan Barcode',
                    icon: FontAwesomeIcons.barcode,
                    themeColor: Styles.green,
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                        scanProcess();
                      });
                    }
                  ),
                  HomeTile(
                    title: 'ISBN',
                    icon: FontAwesomeIcons.search,
                    themeColor: Styles.darkGreen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IsbnEntryScreen()),
                      );
                    }
                  ),
                  HomeTile(
                    title: 'Custom Info',
                    icon: FontAwesomeIcons.edit,
                    themeColor: Styles.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManualBookEntryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Text('You do not have any Libraries to add to.'),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddLibraryScreen(),
                      ),
                    );
                  },
                  child: const Text('Add Library'),
                ),
              ],
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<int> libraryCount() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    // get libraries from database
    var libraryObjects = await callGetLibraries(uid);

    // return count
    return libraryObjects.length;
  }

  void scanProcess() async {
    // scan the barcode
    var barcode = await scanBarcode();

    // if barcode error
    if (barcode == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBookErrorScreen(),
          ));
    } else {
      // get the book
      try {
        var book = await getBookByIsbn(barcode);

        // if book error
        if (book == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBookErrorScreen(),
              ));
        }

        // if we have a book
        if (book != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookToAddScreen(
                book: book,
              ),
            ),
          );
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (err) {
        // catch all whacky scanning errors
        // if book error
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookErrorScreen(),
            ));
      }
    }
  }

  Future<String> scanBarcode() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      return scanResult;
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      return null;
    }
  }

  Future<Book> getBookByIsbn(String isbn) async {
    // check local database
    isbn = isbn.replaceAll('-', '');
    var book = await findBookByIsbn(isbn);

    // if book found return it
    if (book != null) {
      return book;
    } else {
      // if not found
      // check API
      var httpVal = 'https://api2.isbndb.com/book/$isbn';

      // get response
      final response = await http.get(httpVal, headers: {
        HttpHeaders.authorizationHeader: '44346_ad5ea40582a1b18d154a6eb3ff4a3bfc'
      });

      // decode json
      final responseJson = json.decode(response.body);

      // if book was found in api
      if (responseJson['book'] != null) {
        // create new book object
        var newBook = Book.fromApiJson(responseJson);

        // insert into database, return created book
        return callCreateBook(newBook);
      } else {
        // book was not found in database or API
        // return null;
        return null;
      }
    }
  }
}
