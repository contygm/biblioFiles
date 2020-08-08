import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart'; 
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';

class RegularBookScreen extends StatefulWidget {
  final BookLibrary bookLibrary;
  final Library lib;
  RegularBookScreen(this.lib, this.bookLibrary);

  @override
  _RegularBookScreenState createState() => _RegularBookScreenState();
}

class _RegularBookScreenState extends State<RegularBookScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Image(image: NetworkImage(widget.bookLibrary.book.bookImg)),
          Text('Title: ${widget.bookLibrary.book.title}'),
          Text('Author: ${widget.bookLibrary.book.author}'),
          SwitchListTile(
              title: Text('Loanable'),
              value: widget.bookLibrary.loanable,
              onChanged: (value) async {
                setState(() {
                  print('_loanable');
                  widget.bookLibrary.loanable = !widget.bookLibrary.loanable;
                });
                await updateLibraryBook(widget.bookLibrary);
              }),
          RaisedButton(
              child: Text('Checkout'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('checkoutForm', arguments: widget.bookLibrary);
              }),
          RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                  BooksTileListScreen.routeName,
                  arguments: widget.lib),
              child: Text('Done'))
        ]),
      ),
    );
  }
}
