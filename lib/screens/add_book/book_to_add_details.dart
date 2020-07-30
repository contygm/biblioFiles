import 'package:flutter/material.dart';

import '../../model/book.dart';
import 'package:biblioFiles/templates/default_template.dart';
import 'package:flutter/cupertino.dart';

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
  final Book book;
  BookDetailsForm({this.book});
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
            initialValue: book.bookTitle,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            initialValue: book.bookAuthor,
            decoration: InputDecoration(
              labelText: 'Author',
            ),
          ),
          TextFormField(
            initialValue: book.isbn_10,
            decoration: InputDecoration(
              labelText: 'ISBN10',
            ),
          ),
          TextFormField(
            initialValue: book.isbn_13,
            decoration: InputDecoration(
              labelText: 'ISBN13',
            ),
          ),
          TextFormField(
            initialValue: book.pageCount.toString(),
            decoration: InputDecoration(
              labelText: 'Pages',
            ),
          ),
          TextFormField(
            initialValue: book.bookLang,
            decoration: InputDecoration(
              labelText: 'Language',
            ),
          ),
          LibrarySelector(),
          RaisedButton(
            onPressed: () async {},
            child: Text('Approve'),
          ),
        ],
      ),
    );
  }
}

class LibrarySelector extends StatefulWidget {
  @override
  _LibrarySelector createState() => _LibrarySelector();
}

class _LibrarySelector extends State<LibrarySelector> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 25,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurple,
      ),
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
    );
  }
}
