import 'package:biblioFiles/components/library_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/library.dart';
import '../../styles.dart';
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
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: Text('Enter your book\'s info:', 
                  style: Styles.header2DarkGreenStyle,
                  textAlign: TextAlign.center,
                ),
              ),
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
              ),
              TextFormField(
                maxLength: 10,
                controller: _isbn10Controller,
                decoration: InputDecoration(
                  labelText: 'ISBN10',
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
              ),
              TextFormField(
                maxLength: 13,
                controller: _isbn13Controller,
                decoration: InputDecoration(
                  labelText: 'ISBN13',
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
              ),
              TextFormField(
                controller: _pagesController,
                decoration: InputDecoration(
                  labelText: 'Pages',
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
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ]
              ),
              TextFormField(
                controller: _languageController,
                decoration: InputDecoration(
                  labelText: 'Language',
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
              ),
              LibraryDropdown(
                includeView: false,
                includeTitle: false,
                isGreen: true,
                padding: 1.0,
                selectedLibrary: selectedLibrary,
                finalLibraries: finalLibraries,
                onChanged: (value) {
                  setState(() {
                    selectedLibrary = value;
                  });
                },
              ),
              approveButton()
            ],
          ),
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

  Widget approveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: <Widget>[
          ButtonTheme(
            buttonColor: Styles.yellow,
            minWidth: (MediaQuery.of(context).size.width * 0.25),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
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
              child: Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FaIcon(FontAwesomeIcons.solidThumbsUp, 
                      color: Styles.offWhite, 
                      size: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Text('Approve', 
                    style: Styles.smallWhiteBoldButtonLabel,
                    textAlign: TextAlign.center
                  ),
                ],
              )
            )
          ),
        ],
      ),
    );
  }
}
