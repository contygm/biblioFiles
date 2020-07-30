import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../templates/default_template.dart';
import 'isbn_entry_screen.dart';

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
            onPressed: () async {
              //_callScanBarcode();
            },
            child: const Text('Scan Barcode'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
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
            onPressed: () async {
              //_callWriteInfo();
            },
            child: const Text('Write Info'),
          ),
        ),
      ])
    ]));
  }
}
