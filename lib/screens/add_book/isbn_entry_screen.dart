import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../styles.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('Enter a 10 or 13 digit ISBN number', 
                  style: Styles.header2DarkGreenStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              TextFormField(
                maxLength: 13,
                decoration: InputDecoration(
                  labelText: 'ISBN Number',
                  labelStyle: TextStyle(color: Styles.green),
                  focusColor: Styles.green,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.darkGreen
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.green
                    )
                  )
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'ISBN is required.';
                  } else if (value.length != 10 || value.length != 13) {
                    return 'ISBN must be 10 or 13 digits long.';
                  }
                  isbn = value;
                  return null;
                }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: <Widget>[
                    ButtonTheme(
                      buttonColor: Styles.green,
                      minWidth: (MediaQuery.of(context).size.width * 0.25),
                      height: (MediaQuery.of(context).size.width * 0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: RaisedButton(
                        elevation: 3,
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
                        child: Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: FaIcon(FontAwesomeIcons.search, 
                                color: Styles.offWhite, 
                                size: MediaQuery.of(context).size.width * 0.05),
                            ),
                            Text('Find Info', 
                              style: Styles.smallWhiteBoldButtonLabel,
                              textAlign: TextAlign.center
                            ),
                          ],
                        )
                      )
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // ignore: missing_return
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
