import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/library.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import 'add_book_success_screen.dart';

class BookToAddScreen extends StatelessWidget {
  // declare field to hold book
  final Book book;
  // require incoming book
  BookToAddScreen({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: BookDetails(book: book));
  }
}

class BookDetails extends StatefulWidget {
  final Book book;
  BookDetails({this.book});
  @override
  BookDetailsForm createState() => BookDetailsForm(book: book);
}

class BookDetailsForm extends State<BookDetails> {
  BookDetailsForm({this.book});
  Book book;
  Library selectedLibrary;
  final _key = GlobalKey<FormState>();

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
                  submit(book, selectedLibrary);

                  // get the library record
                  var libId = selectedLibrary.id;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSuccessScreen(libId: libId),
                    ),
                  );
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

  @override
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
                child: Text('Does this look correct?', 
                  style: Styles.header2DarkGreenStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              (book.bookImg.length > 1 ? 
                Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(book.bookImg),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                )
                : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                    child: Container(
                      color: Styles.darkGreen,
                      child: Icon(Icons.import_contacts, 
                        color: Styles.offWhite, 
                        size: 150),
                    ),
                )
              ),
              TextFormField(
                readOnly: book.bookTitle == '' ? false : true,
                initialValue: book.bookTitle,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: book.bookTitle == '' ? Styles.darkGreen : Styles.darkGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.bookTitle == '' ? Styles.darkGreen : Styles.darkGrey,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.bookTitle == '' ? Styles.green : Styles.darkGrey
                    )
                  )
                ),
                onSaved: (newValue) => book.bookTitle = newValue,
              ),
              TextFormField(
                readOnly: book.bookAuthor == '' ? false : true,
                initialValue: book.bookAuthor,
                decoration: InputDecoration(
                  labelText: 'Author',
                  labelStyle: TextStyle(color: book.bookAuthor == '' ? Styles.darkGreen : Styles.darkGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.bookAuthor == '' ? Styles.darkGreen : Styles.darkGrey,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.bookAuthor == '' ? Styles.green : Styles.darkGrey
                    )
                  )
                ),
                onSaved: (newValue) => book.bookAuthor = newValue,
              ),
              TextFormField(
                readOnly: book.isbn_10 == '' ? false : true,
                initialValue: book.isbn_10,
                decoration: InputDecoration(
                  labelText: 'ISBN10',
                  labelStyle: TextStyle(color: book.isbn_10 == '' ? Styles.darkGreen : Styles.darkGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.isbn_10 == '' ? Styles.darkGreen : Styles.darkGrey,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.isbn_10 == '' ? Styles.green : Styles.darkGrey
                    )
                  )
                ),
                onSaved: (newValue) => book.isbn_10 = newValue,
              ),
              TextFormField(
                readOnly: book.isbn_13 == '' ? false : true,
                initialValue: book.isbn_13,
                decoration: InputDecoration(
                  labelText: 'ISBN13',
                  labelStyle: TextStyle(color: book.isbn_13 == '' ? Styles.darkGreen : Styles.darkGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.isbn_13 == '' ? Styles.darkGreen : Styles.darkGrey,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.isbn_13 == '' ? Styles.green : Styles.darkGrey
                    )
                  )
                ),
                onSaved: (newValue) => book.isbn_13 = newValue,
              ),
              TextFormField(
                readOnly: book.pageCount.toString() == '' ? false : true,
                initialValue: book.pageCount.toString(),
                decoration: InputDecoration(
                  labelText: 'Pages',
                  labelStyle: TextStyle(color: book.pageCount.toString() == '' ? Styles.darkGreen : Styles.darkGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.pageCount.toString() == '' ? Styles.darkGreen : Styles.darkGrey,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: book.pageCount.toString() == '' ? Styles.green : Styles.darkGrey
                    )
                  )
                ),
                onSaved: (newValue) => book.pageCount = int.parse(newValue),
              ),
              TextFormField(
                initialValue: book.bookLang,
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
                onSaved: (newValue) => book.bookLang = newValue,
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
              approveButton(),
            ],
          ),
        ),
      );
    }
  }

  void submit(Book book, Library selectedLibrary) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      // get UID
      final auth = FirebaseAuth.instance;
      final user = await auth.currentUser();
      final uid = user.uid;

      // addBookToLibrary
      await addBookToLibrary(book, selectedLibrary, uid);
    }
  }
}
