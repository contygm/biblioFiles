import 'dart:convert';
import 'dart:io';
import 'book_to_add_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../model/book.dart';
import '../../templates/default_template.dart';

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
                    var book = await checkIsbn(isbn);
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
                    } else {
                      // if book is not valid

                    }
                  }
                },
                child: Text('Submit'))
          ],
        ));
  }

  Future<Book> checkIsbn(String isbn) async {
    // check local database

    // check API
    var httpVal = 'https://api2.isbndb.com/book/$isbn';
    final response = await http.get(httpVal, headers: {
      HttpHeaders.authorizationHeader: '44346_ad5ea40582a1b18d154a6eb3ff4a3bfc'
    });

    // decode json
    final responseJson = json.decode(response.body);
    if (responseJson['book'] != null) {
      var newBook = Book.fromApiJson(responseJson);
      return newBook;
    }

    return null;
  }
}
