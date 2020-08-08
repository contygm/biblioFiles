import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import 'single_book_screen.dart';
import '../../templates/default_template.dart';

class EditBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new EditBook());
  }
}

class EditBook extends StatefulWidget {
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _key = GlobalKey<FormState>();
  List<bool> values = [true, false];

  @override
  Widget build(BuildContext context) {
    final BookLibrary book = ModalRoute.of(context).settings.arguments;
    return Form(
        key: _key,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            initialValue: '${book.book.title}',
            readOnly: true,
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              initialValue: '${book.book.author}',
              readOnly: true),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Currently Reading'),
              value: book.currentlyreading,
              onChanged: (newValue) {
                setState(() {
                  book.currentlyreading = newValue;
                });
              },
              items: values
                  .map((item) => DropdownMenuItem<bool>(
                        child: Text('$item'),
                        value: item,
                      ))
                  .toList()),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Checked Out'),
              value: book.checkedout,
              onChanged: (newValue) {
                setState(() {
                  book.checkedout = newValue;
                });
              },
              items: values
                  .map((item) => DropdownMenuItem<bool>(
                        child: Text('$item'),
                        value: item,
                      ))
                  .toList()),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Private Book'),
              value: book.private,
              onChanged: (newValue) {
                setState(() {
                  book.private = newValue;
                });
              },
              items: values
                  .map((item) => DropdownMenuItem<bool>(
                        child: Text('$item'),
                        value: item,
                      ))
                  .toList()),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Loanable Book'),
              value: book.loanable,
              onChanged: (newValue) {
                setState(() {
                  book.loanable = newValue;
                });
              },
              items: values
                  .map((item) => DropdownMenuItem<bool>(
                        child: Text('$item'),
                        value: item,
                      ))
                  .toList()),
          DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Rating'),
              value: book.rating,
              onChanged: (newValue) {
                setState(() {
                  book.rating = newValue;
                });
              },
              items: <int>[1, 2, 3, 4, 5]
                  .map((item) => DropdownMenuItem<int>(
                        child: Text('$item'),
                        value: item,
                      ))
                  .toList()),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Notes'),
            onChanged: (value) {
              setState(() {
                book.notes = value;
              });
            },
          ),
          RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SingleBookScreen.routeName, arguments: book);
              },
              child: Text('View book')),
          RaisedButton(
              onPressed: () async {
                //submit info to db and navigate to libraries
                await updateLibraryBook(book);
                final message =
                    SnackBar(content: Text('Changes have been made!'));
                Scaffold.of(context).showSnackBar(message);
              },
              child: Text('Save'))
        ]));
  }
}
