
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';
import '../models/library.dart';
import '../screens/checkout/checkedout_book_screen.dart';
import '../screens/checkout/regular_book_screen.dart';
import '../screens/checkout/unloanable_book_screen.dart';

class BookTile extends StatelessWidget {

  BookTile({
    this.sortParam,
    this.bookLib,
    this.library
  });

  final String sortParam;
  final BookLibrary bookLib;
  final Library library;

  dynamic getValueFromSortParam(Book book) {
    dynamic value;
    switch (sortParam) {
      case 'Dewey Decimal':
        value = book.dewey ?? '-';
        break;
      case 'Pages':
        value = book.pages ?? '-';
        break;
      case 'Title':
        value = book.title ?? '-';
        break;
      case 'Language':
        value = book.lang ?? '-';
        break;
      default:
        value = book.author ?? '-';
    }

    return value;
  }

  // determines the text for the right side of tile
  // based on sort and checkout statuses
  Widget bookTileEnd(BookLibrary bookLib) {
    if (sortParam != 'Author' && sortParam != 'Title' && bookLib.checkedout) {
      dynamic value = getValueFromSortParam(bookLib.book);
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('$value', style: TextStyle(color: Colors.green)),
            Text('OUT', style: TextStyle(color: Colors.red))
          ]);
    } else if (bookLib.checkedout) {
      return Text('OUT', style: TextStyle(color: Colors.red));
    } else if (sortParam != 'Author' && sortParam != 'Title') {
      dynamic value = getValueFromSortParam(bookLib.book);
      return Text('$value', style: TextStyle(color: Colors.green));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: bookLib.checkedout ? Colors.red : Colors.transparent),
          color: bookLib.loanable ? Colors.transparent : Colors.grey[400]),
      child: ListTile(
        title: Text(bookLib.book.title),
        subtitle: Text('${bookLib.book.author}'),
        trailing: bookTileEnd(bookLib),
        onTap: () {
          if (bookLib.checkedout) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckedoutBookScreen(library, bookLib)));
          } else if (!bookLib.loanable) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UnloanableBookScreen(library, bookLib)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegularBookScreen(library, bookLib)));
          }
        },
      ),
    );
  }
}