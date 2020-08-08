import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/library.dart';
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
  String selectedLibrary;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          Image.network(
            book.bookImg,
            height: 100,
            width: 100,
          ),
          TextFormField(
            readOnly: book.bookTitle == '' ? false : true,
            initialValue: book.bookTitle,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            onSaved: (newValue) => book.bookTitle = newValue,
          ),
          TextFormField(
            readOnly: book.bookAuthor == '' ? false : true,
            initialValue: book.bookAuthor,
            decoration: InputDecoration(
              labelText: 'Author',
            ),
            onSaved: (newValue) => book.bookAuthor = newValue,
          ),
          TextFormField(
            readOnly: book.isbn_10 == '' ? false : true,
            initialValue: book.isbn_10,
            decoration: InputDecoration(
              labelText: 'ISBN10',
            ),
            onSaved: (newValue) => book.isbn_10 = newValue,
          ),
          TextFormField(
            readOnly: book.isbn_13 == '' ? false : true,
            initialValue: book.isbn_13,
            decoration: InputDecoration(
              labelText: 'ISBN13',
            ),
            onSaved: (newValue) => book.isbn_13 = newValue,
          ),
          TextFormField(
            readOnly: book.pageCount.toString() == '' ? false : true,
            initialValue: book.pageCount.toString(),
            decoration: InputDecoration(
              labelText: 'Pages',
            ),
            onSaved: (newValue) => book.pageCount = int.parse(newValue),
          ),
          TextFormField(
            readOnly: book.bookLang == '' ? false : true,
            initialValue: book.bookLang,
            decoration: InputDecoration(
              labelText: 'Language',
            ),
            onSaved: (newValue) => book.bookLang = newValue,
          ),
          FutureBuilder<List<Library>>(
              future: getLibraries(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Library'),
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
              submit(book, selectedLibrary);

              // get the library record
              var libRecord = await getLibraryRecord(selectedLibrary);
              var libId = libRecord.id;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSuccessScreen(libId: libId),
                ),
              );
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

  void submit(Book book, String selectedLibrary) async {
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
