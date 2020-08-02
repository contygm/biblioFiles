import 'dart:convert';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../templates/default_template.dart';
import 'book_to_add_details.dart';

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

        // get the book
        var book = await getBookByIsbn(barcode);
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
      },
    );
  }

  TextEditingController errorController = TextEditingController();

  Future<String> scanBarcode() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      return scanResult;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          errorController.text = 'Camera Access Denied';
        });
      } else {
        setState(() {
          errorController.text = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        errorController.text = 'Nothing Scanned';
      });
    } catch (e) {
      setState(() {
        errorController.text = 'Unknown error $e';
      });
    }
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
      // throw error
      throw ('Book was not found in database or API');
    }
  }
}
