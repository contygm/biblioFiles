import 'package:flutter/material.dart';
import '../../models/bookLibrary.dart';
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';


class UnloanableBookScreen extends StatefulWidget {
  final BookLibrary bookLibrary;
  UnloanableBookScreen(this.bookLibrary);

  @override
  _UnloanableBookScreenState createState() => _UnloanableBookScreenState();
}

class _UnloanableBookScreenState extends State<UnloanableBookScreen> {
  BookLibrary get theBook =>
    widget.bookLibrary;

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image(image: NetworkImage(widget.bookLibrary.book.bookImg)),
            Text('Title: ${widget.bookLibrary.book.title}'),
            Text('Author: ${widget.bookLibrary.book.author}'),
            SwitchListTile(
              title: Text('Loanable'),
              value: widget.bookLibrary.loanable,
              onChanged: (value) {
                setState(() {
                   print('_loanable');
                  widget.bookLibrary.loanable = !widget.bookLibrary.loanable;
                });
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