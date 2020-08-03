import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'add_book_success_screen.dart';

class ManualBookEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: ManualBookEntry());
  }
}

class ManualBookEntry extends StatefulWidget {
  @override
  _ManualBookEntry createState() => _ManualBookEntry();
}

class _ManualBookEntry extends State<ManualBookEntry> {
  String selectedLibrary;

  final _key = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbn13Controller = TextEditingController();
  final TextEditingController _isbn10Controller = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter a title';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            controller: _authorController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter an author';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Author',
            ),
          ),
          TextFormField(
            controller: _isbn10Controller,
            decoration: InputDecoration(
              labelText: 'ISBN10',
            ),
          ),
          TextFormField(
            controller: _isbn13Controller,
            decoration: InputDecoration(
              labelText: 'ISBN13',
            ),
          ),
          TextFormField(
            controller: _pagesController,
            decoration: InputDecoration(
              labelText: 'Pages',
            ),
          ),
          TextFormField(
            controller: _languageController,
            decoration: InputDecoration(
              labelText: 'Language',
            ),
          ),
          FutureBuilder<List<Library>>(
              future: getLibraries(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Libary'),
                      value: selectedLibrary,
                      onChanged: (newValue) {
                        setState(() {
                          selectedLibrary = newValue;
                        });
                      },
                      items: snapshot.data
                          .map((item) => DropdownMenuItem<String>(
                                child: Text(item.libraryName),
                                value: item.libraryName,
                              ))
                          .toList());
                } else {
                  return CircularProgressIndicator();
                }
              }),
          RaisedButton(
            onPressed: () async {
              var isValid = await submit(selectedLibrary);

              if (isValid) {
                // get the library record
                var libRecord = await getLibraryRecord(selectedLibrary);
                var libId = libRecord.id;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSuccessScreen(libId: libId),
                  ),
                );
              }
            },
            child: Text('Approve'),
          ),
        ],
      ),
    );
  }

  Future<Library> getLibraryRecord(String libraryName) async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    return await findLibraryRecord(selectedLibrary, uid);
  }

  Future<bool> submit(String selectedLibrary) async {
    if (_key.currentState.validate()) {
      var book = Book.empty();
      book.bookAuthor = _authorController.text.trim();
      book.pageCount = int.tryParse(_pagesController.text.trim()) != null
          ? int.parse(_pagesController.text.trim())
          : 0;
      book.isbn_10 = _isbn10Controller.text.trim();
      book.isbn_13 = _isbn13Controller.text.trim();
      book.bookTitle = _titleController.text.trim();
      book.bookLang = _languageController.text.trim();

      // get UID
      final auth = FirebaseAuth.instance;
      final user = await auth.currentUser();
      final uid = user.uid;

      // insert into database, return created book
      var newBook = await callCreateBook(book);

      // addBookToLibrary
      await addBookToLibrary(newBook, selectedLibrary, uid);

      return true;
    } else {
      return false;
    }
  }

  Future<List<Library>> getLibraries() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    // get libraries from database
    var libraryObjects = await callGetLibraries(uid);

    // return libraries
    return libraryObjects;
  }
}
