import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../templates/default_template.dart';
import 'add_book_error_screen.dart';
import 'book_to_add_details_screen.dart';

class IsbnEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: IsbnEntry());
  }
}

class IsbnEntry extends StatefulWidget {
  @override
  IsbnEntryForm createState() => IsbnEntryForm();
}

class IsbnEntryForm extends State<IsbnEntry> {
  String isbn = '';
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
                decoration: const InputDecoration(labelText: 'ISBN Number'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'ISBN is required.';
                  }
                  isbn = value;
                  return null;
                }),
            RaisedButton(
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    // get the book
                    var book = await getBookByIsbn(isbn);
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
                  }
                },
                child: Text('Submit'))
          ],
        ));
  }

  Future<Book> getBookByIsbn(String isbn) async {
    // check local database
    isbn = isbn.replaceAll('-', '');
    var book = await findBookByIsbn(isbn);

    // if book error
    if (book == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBookErrorScreen(),
          ));
    }

    // if book found return it
    if (book != null) {
      return book;
    } else {
      // if not found
      // check API
      var httpVal = 'https://api2.isbndb.com/book/$isbn';

      // get response
      final response = await http.get(httpVal, headers: {
        HttpHeaders.authorizationHeader:
            '44346_ad5ea40582a1b18d154a6eb3ff4a3bfc'
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
        // if book error
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookErrorScreen(),
            ));
      }
    }
  }
}
