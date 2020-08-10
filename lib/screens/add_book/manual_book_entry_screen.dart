import 'package:biblioFiles/components/library_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/library_dropdown.dart';
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
  Library selectedLibrary;

  final _key = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _isbn13Controller = TextEditingController();
  final TextEditingController _isbn10Controller = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLibraries();
  }

  List<Library> finalLibraries = [];
  bool lookLibrary = false;
  void getLibraries() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    var libraries = await callGetLibraries(uid);
    setState(() {
      lookLibrary = true;
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    if (lookLibrary == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      return Form(
        key: _key,
        child: ListView(
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
              maxLength: 10,
              controller: _isbn10Controller,
              decoration: InputDecoration(
                labelText: 'ISBN10',
              ),
            ),
            TextFormField(
              maxLength: 13,
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
               keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ]
            ),
            TextFormField(
              controller: _languageController,
              decoration: InputDecoration(
                labelText: 'Language',
              ),
            ),
            LibraryDropdown(
              includeView: false,
              selectedLibrary: selectedLibrary,
              finalLibraries: finalLibraries,
              onChanged: (value) {
                setState(() {
                  selectedLibrary = value;
                });
              },
            ),
            RaisedButton(
              onPressed: () async {
                if (selectedLibrary == null) {
                  final message =
                      SnackBar(content: Text('Library is required!'));
                  Scaffold.of(context).showSnackBar(message);
                } else {
                  var isValid = await submit(selectedLibrary);

                  if (isValid) {
                    var libId = selectedLibrary.id;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSuccessScreen(libId: libId),
                      ),
                    );
                  }
                }
              },
              child: Text('Approve'),
            ),
          ],
        ),
      );
    }
  }

  Future<bool> submit(Library selectedLibrary) async {
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
}
