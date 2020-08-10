
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';
import '../models/library.dart';
import 'checkbox_tile.dart';
import '../styles.dart';

class BookTile extends StatelessWidget {

  BookTile({
    this.sortParam,
    this.bookLib,
    this.library,
    this.onChanged,
    this.hasCheckbox = false
  });

  final String sortParam;
  final BookLibrary bookLib;
  final Library library;
  final bool hasCheckbox;
  final Function onChanged;

  dynamic getValueFromSortParam(Book book) {
    dynamic value;
    switch (sortParam) {
      case 'Dewey Decimal':
        value = book.dewey ?? '-';
        break;
      case 'Pages':
        value = (book.pages == null || book.pages == 0) ? '-' : book.pages;
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

  // TODO cut off text
  Widget checkboxTileEnd(BookLibrary bookLib) {
    if (sortParam != 'Author' && sortParam != 'Title' && bookLib.checkedout) {
      dynamic value = getValueFromSortParam(bookLib.book);
      return Container(
        height: 50,
        child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Styles.darkGreen
                    ),
                    child: Text('$value',
                    textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white))))
                    ),
              Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text('OUT', style: TextStyle(color: Colors.red))))
            ]),
      );
    } else if (bookLib.checkedout) {
      return Container(
        height: 50,
        child: Align(alignment: FractionalOffset.bottomCenter,
          child: Text('OUT', style: TextStyle(color: Colors.red))),
      );
    } else if (sortParam != 'Author' && sortParam != 'Title') {
      dynamic value = getValueFromSortParam(bookLib.book);
      return  Container(
        height: 50,
        child: Align(alignment: FractionalOffset.topCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.darkGreen
            ),
            child: Text('$value', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)))),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: bookLib.checkedout 
          ? Colors.red : Colors.transparent),
        color: bookLib.loanable ? Colors.transparent : Colors.grey[400]
      ),
      child: hasCheckbox ? CheckboxTile(
        value: bookLib.unpacked,
        title: bookLib.book.title,
        author: bookLib.book.author,
        detailText: checkboxTileEnd(bookLib),
        onChanged: onChanged
      ) : ListTile(
        title: Text(bookLib.book.title),
        subtitle: Text('${bookLib.book.author}'),
        trailing: bookTileEnd(bookLib),
        onTap: onChanged
      ),
    );
  }
}