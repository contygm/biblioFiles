import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart'; 
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';


class CheckedoutBookScreen extends StatefulWidget {
  final BookLibrary bookLibrary;
  final Library lib;
  CheckedoutBookScreen(this.lib, this.bookLibrary);

  @override
  _CheckedoutBookScreenState createState() => _CheckedoutBookScreenState();
}

class _CheckedoutBookScreenState extends State<CheckedoutBookScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Image(image: NetworkImage(widget.bookLibrary.book.bookImg)),
          Text('Title: ${widget.bookLibrary.book.title}'),
          Text('Author: ${widget.bookLibrary.book.author}'),
          Text('Note: ${widget.bookLibrary.notes}'),
          SwitchListTile(
              title: Text('Loanable'),
              value: widget.bookLibrary.loanable,
              onChanged: null),
          RaisedButton(
              child: Text('Check In'),
              onPressed: () async {
                //print('check in');
                setState(() {
                  widget.bookLibrary.checkedout =
                      !widget.bookLibrary.checkedout;
                  widget.bookLibrary.notes = '';
                });
                await updateLibraryBook(widget.bookLibrary);
              }),
          RaisedButton(
              onPressed: () => Navigator.of(context)
                .pushNamed( 
                  BooksTileListScreen.routeName, 
                  arguments: widget.lib),
              child: Text('Done'))
        ]),
      ),
    );
  }
}
