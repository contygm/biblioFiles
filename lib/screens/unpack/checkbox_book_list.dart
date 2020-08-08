import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';

Library library;

class CheckoutBookListScreen extends StatelessWidget {
  static final String routeName = 'checkboxBookList';
  @override
  Widget build(BuildContext context) {
    library = ModalRoute.of(context).settings.arguments;
    return Container(child: LoadBooksTileListScreen());
  }
}

class LoadBooksTileListScreen extends StatefulWidget {
  @override
  _LoadBooksTileListScreenState createState() =>
      _LoadBooksTileListScreenState();
}

class _LoadBooksTileListScreenState extends State<LoadBooksTileListScreen> {
  // keep track of sort order
  bool _isAscending = true;
  // keep track of sort param, default = Author
  String sortParam = 'Author';

  @override
  void initState() {
    super.initState();
    getBooksinLibrary();
  }

  bool booksSearched = false;
  List<dynamic> allBooks = [];
  List<dynamic> organizedBooks = [];
  void getBooksinLibrary() async {
    var books = await callGetLibraryBooks(library.id);
    setState(() {
      booksSearched = true;
      allBooks = books;
      organizedBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (booksSearched = false) {
      return Container(child: CircularProgressIndicator());
    } else {
      return DefaultTemplate(
        content: Container(
            child: Column(
          children: [
            filterSortBar(library.libraryName),
            Expanded(child: bookTileList())
          ],
        )),
      );
    }
  }

  Widget bookTileList() {
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: organizedBooks.length,
        itemBuilder: (context, index) {
          return bookTile(organizedBooks[index]);
        },
        separatorBuilder: (context, index) => const Divider());
  }

  Widget bookTile(BookLibrary bookLib) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: bookLib.checkedout ? Colors.red : Colors.transparent),
          color: bookLib.loanable ? Colors.transparent : Colors.grey[400]),
      child: CheckboxTile(
        value: bookLib.unpacked,
        label: bookLib.book.title,
        // subtitle: Text('${bookLib.book.author}'),
        // trailing: bookTileEnd(bookLib),
        onChanged: (value) {
          setState(() {
            bookLib.unpacked = !bookLib.unpacked;
          });
        },
      ),
    );
  }

  dynamic getValueFromSortParam(Book book) {
    dynamic value;
    switch (sortParam) {
      case 'Dewey Decimal':
        value = book.dewey;
        break;
      case 'Pages':
        value = book.pages;
        break;
      case 'Title':
        value = book.title;
        break;
      case 'Language':
        value = book.lang;
        break;
      default:
        value = book.author;
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

  // TODO EXTRACT into component
  Widget filterSortBar(String libraryName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Row(children: [
        Text(libraryName, style: TextStyle(fontSize: 25)),
        Spacer(flex: 1),
        ButtonBar(children: [filterButton(), sortButton()])
      ]),
    );
  }

  Widget filterButton() {
    var choices = <String>[
      'All',
      'Packed',
      'Unpacked',
      'Checked Out',
      'Checked In'
    ];

    return PopupMenuButton(
        icon: Icon(Icons.filter_list),
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 'Packed':
                organizedBooks = allBooks.where((b) => !b.unpacked).toList();
                break;
              case 'Unpacked':
                organizedBooks = allBooks.where((b) => b.unpacked).toList();
                break;
              case 'Checked Out':
                organizedBooks = allBooks.where((b) => b.checkedout).toList();
                break;
              case 'Checked In':
                organizedBooks = allBooks.where((b) => !b.checkedout).toList();
                break;
              default:
                organizedBooks = allBooks;
            }
          });
        },
        itemBuilder: (context) {
          return choices.map<PopupMenuItem<String>>((value) {
            return PopupMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList();
        });
  }

  Widget sortButton() {
    var choices = <String>[
      'Author',
      'Dewey Decimal',
      'Pages',
      'Title',
      'Language'
    ];

    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isAscending = !_isAscending;
          organizedBooks = organizedBooks.reversed.toList();
        });
      },
      child: PopupMenuButton(
          icon: _isAscending
              ? Icon(Icons.arrow_upward)
              : Icon(Icons.arrow_downward),
          onSelected: (value) {
            setState(() {
              switch (value) {
                case 'Dewey Decimal':
                  organizedBooks
                      .sort((a, b) => a.book.dewey.compareTo(b.book.dewey));
                  break;
                case 'Pages':
                  organizedBooks
                      .sort((a, b) => a.book.pages.compareTo(b.book.pages));
                  break;
                case 'Title':
                  organizedBooks
                      .sort((a, b) => a.book.title.compareTo(b.book.title));
                  break;
                case 'Language':
                  organizedBooks
                      .sort((a, b) => a.book.lang.compareTo(b.book.lang));
                  break;
                default:
                  organizedBooks
                      .sort((a, b) => a.book.author.compareTo(b.book.author));
              }
              sortParam = value;
              _isAscending = true;
            });
          },
          itemBuilder: (context) {
            return choices.map<PopupMenuItem<String>>((value) {
              return PopupMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList();
          }),
    );
  }
}


class CheckboxTile extends StatelessWidget {
  const CheckboxTile({
    this.label,
    this.value,
    this.onChanged,
  });

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}