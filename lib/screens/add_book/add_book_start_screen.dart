import 'package:biblioFiles/screens/add_book/add_book_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../templates/default_template.dart';
import 'barcode_entry_screen.dart';
import 'isbn_entry_screen.dart';
import 'manual_book_entry_screen.dart';

class AddBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
        content: Row(children: <Widget>[
      Column(children: [
        Text('How do you want to add your Book?'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarcodeEntryScreen()),
              );
            },
            child: const Text('Scan Barcode'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IsbnEntryScreen()),
              );
            },
            child: const Text('ISBN #'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ManualBookEntryScreen()),
              );
            },
            child: const Text('Write Info'),
          ),
        ),
      ])
    ]));
  }
}
