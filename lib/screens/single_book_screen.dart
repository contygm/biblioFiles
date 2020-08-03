import 'package:flutter/material.dart';
import '../models/bookLibrary.dart';
import '../templates/default_template.dart';
import '../components/floating_back_button.dart';

class SingleBookScreen extends StatefulWidget {
  static const routeName = 'singleBookScreen';

  @override
  _SingleBookScreenState createState() => _SingleBookScreenState();
}

class _SingleBookScreenState extends State<SingleBookScreen> {
  bool _isSmall = true;
  @override
  Widget build(BuildContext context) {
    final BookLibrary bookLibrary = ModalRoute.of(context).settings.arguments;

    return DefaultTemplate(
      floatingAction: FloatingBackButton(context),
      content: Card(
        child: _isSmall ? 
          smallInfo(context, bookLibrary) : 
          bigInfo(context, bookLibrary)
      )
    );
  }

  Widget smallInfo(BuildContext context, BookLibrary bookLibrary) {
    return Column(
      children: [
        Image(image: NetworkImage(bookLibrary.book.bookImg)),
        Text('Title: ${bookLibrary.book.title}'),
        Text('Author: ${bookLibrary.book.author}'),
        IconButton(
          icon: Icon(Icons.expand_more), 
          onPressed: () {
            setState(() { 
              _isSmall = !_isSmall; 
            });
          }
        )
      ]
    );
  }

  Widget bigInfo(BuildContext context, BookLibrary bookLibrary) {
    return Column(
      children: [
        Image(image: NetworkImage(bookLibrary.book.bookImg)),
        Text('Title: ${bookLibrary.book.title}'),
        Text('Author: ${bookLibrary.book.author}'),
        Text('ISBN 10: ${bookLibrary.book.isbn_10}'),
        Text('ISBN 13: ${bookLibrary.book.isbn_13}'),
        Text('Dewey Decimal: ${bookLibrary.book.deweyd}'),
        Text('Pages: ${bookLibrary.book.pageCount}'),
        Text('Language: ${bookLibrary.book.bookLang}'),
        Text('Currently Reading: ${bookLibrary.currentlyreading}'),
        Text('Checked Out: ${bookLibrary.checkedout}'),
        Text('Private: ${bookLibrary.private}'),
        Text('Loadnable: ${bookLibrary.loanable}'),
        Text('Rating: ${bookLibrary.rating}'),
        Text('Notes: ${bookLibrary.notes}'),
        IconButton(
          icon: Icon(Icons.expand_less), 
          onPressed: () {
            setState(() { 
              _isSmall = !_isSmall; 
            });
          }
        )
      ]
    );
  }
}