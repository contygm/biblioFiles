import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../templates/default_template.dart';
import 'add_book_error_screen.dart';
import 'book_to_add_details_screen.dart';

class BarcodeEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: BarcodeEntry());
  }
}

class BarcodeEntry extends StatefulWidget {
  @override
  _BarcodeEntry createState() => _BarcodeEntry();
}

class _BarcodeEntry extends State<BarcodeEntry> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Scan Barcode'),
      onPressed: () async {
        // scan the barcode
        var barcode = await scanBarcode();

        // if barcode error
        if (barcode == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBookErrorScreen(),
              ));
        }

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
      },
    );
  }

  Future<String> scanBarcode() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      return scanResult;
    } catch (err) {
      return null;
    }
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
