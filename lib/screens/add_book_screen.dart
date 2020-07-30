import 'package:flutter/material.dart';
import '../templates/default_template.dart';

class AddBookScreen extends StatelessWidget {
  static final routes = {'scanBarcode'};

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
              _callScanBarcode();
            },
            child: const Text('Scan Barcode'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _callIsbnEntry();
            },
            child: const Text('ISBN #'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {
              _callWriteInfo();
            },
            child: const Text('Write Info'),
          ),
        ),
      ])
    ]));
  }

  void _callScanBarcode() async {}

  void _callIsbnEntry() async {}

  void _callWriteInfo() async {}
}
