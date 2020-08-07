import 'package:flutter/material.dart';
import '../../models/bookLibrary.dart';
import '../../templates/default_template.dart';

class CheckedoutBookScreen extends StatelessWidget {
  final BookLibrary bookLibrary;
  CheckedoutBookScreen(this.bookLibrary);

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(image: NetworkImage(bookLibrary.book.bookImg)),
            Text('Title: ${bookLibrary.book.title}'),
            Text('Author: ${bookLibrary.book.author}'),
            SwitchListTile(
              title: Text('Loanable'),
              value: bookLibrary.loanable,
              onChanged: null
            ),
            RaisedButton(
              child: Text('Check In'),
              onPressed: () {
                print('check in');
              }
            ),
            RaisedButton(
              onPressed: () => 
                Navigator.of(context).pop(context),
              child: Text('Done')
            )
          ]
        ),
      ),
    );
  }
}