
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';
import '../models/library.dart';
import 'checkbox_tile.dart';
import 'book_list_tile.dart';
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

  Widget tileEnd(BookLibrary bookLib) {
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
                      overflow: TextOverflow.ellipsis,
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
              overflow: TextOverflow.ellipsis,
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
        color: bookLib.loanable ? Colors.white : Colors.grey[400],
        boxShadow: [BoxShadow(
          color: Colors.grey,
          blurRadius: 5.0,
          offset: Offset(3.0, 3.0)
        )]
      ),
      child: hasCheckbox ? CheckboxTile(
        value: bookLib.unpacked,
        title: bookLib.book.title,
        author: bookLib.book.author,
        detailText: tileEnd(bookLib),
        onChanged: onChanged
      ) : BookListTile(
        value: bookLib.unpacked,
        title: bookLib.book.title,
        author: bookLib.book.author,
        detailText: tileEnd(bookLib),
        onChanged: onChanged
      ),
    );
  }
}