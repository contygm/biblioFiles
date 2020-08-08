import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/book.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'checkedout_book_screen.dart';
import 'regular_book_screen.dart';
import 'unloanable_book_screen.dart';

Library library;

class BooksTileListScreen extends StatelessWidget {
  static final String routeName = 'booksTileList';
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
      child: ListTile(
        title: Text(bookLib.book.title),
        subtitle: Text('${bookLib.book.author}'),
        trailing: bookTileEnd(bookLib),
        onTap: () {
          if (bookLib.checkedout) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CheckedoutBookScreen(library, bookLib)));
          } else if (!bookLib.loanable) {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => UnloanableBookScreen(library, bookLib)))
                .then((value) {
              setState(() {});
            });
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegularBookScreen(library, bookLib)));
          }
        },
      ),
    );
  }

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

  // screen's title bar that has buttons for filter and sort
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
      'Unloanable',
      'Loanable',
      'Checked Out',
      'Checked In'
    ];

    return PopupMenuButton(
        icon: Icon(Icons.filter_list),
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 'Unloanable':
                organizedBooks = allBooks.where((b) => !b.loanable).toList();
                break;
              case 'Loanable':
                organizedBooks = allBooks.where((b) => b.loanable).toList();
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
        }, // TODO
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
                    .sort((a, b) => a.book.dewey != null ? 
                      a.book.dewey.compareTo(b.book.dewey) : 
                      (b.book.dewey != null ? 1 : 0));
                  break;
                case 'Pages':
                  organizedBooks
                    .sort((a, b) => a.book.pages != null ? 
                      a.book.pages.compareTo(b.book.pages) : 
                      (b.book.pages != null ? 1 : 0));
                  break;
                case 'Title':
                  organizedBooks
                    .sort((a, b) => a.book.title != null ? 
                      a.book.title.compareTo(b.book.title) : 
                      (b.book.title != null ? 1 : 0));
                  break;
                case 'Language':
                  organizedBooks
                    .sort((a, b) => a.book.lang != null ? 
                      a.book.bookLang.compareTo(b.book.bookLang) : 
                      (b.book.bookLang != null ? 1 : 0));
                  break;
                default:
                  organizedBooks
                    .sort((a, b) => a.book.author != null ? 
                      a.book.author.compareTo(b.book.author) : 
                      (b.book.author != null ? 1 : 0));
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

