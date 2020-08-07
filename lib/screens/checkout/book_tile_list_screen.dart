import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';

BookLibrary bookRegular = BookLibrary(
  book: Book(
    "https://media.wired.com/photos/5cdefc28b2569892c06b2ae4/master/w_2560%2Cc_limit/Culture-Grumpy-Cat-487386121-2.jpg", 
    420, 
    'A Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '100.21', 
    1, 
    'R - Professionally Grumpy', 
    'English'
  ),
  notes: 'Excellent resources for how to be grumpy',
  loanable: true,
  checkedout: false,
  id: 1
);

BookLibrary bookOut = BookLibrary(
  book: Book(
    "https://media.wired.com/photos/5cdefc28b2569892c06b2ae4/master/w_2560%2Cc_limit/Culture-Grumpy-Cat-487386121-2.jpg", 
    25, 
    'Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '125.21', 
    1, 
    'O - Professionally Grumpy', 
    'Spanish'
  ),
  notes: 'Excellent resources for how to be grumpy',
  loanable: true,
  checkedout: true,
  id: 1
);

BookLibrary bookUnloanable = BookLibrary(
  book: Book(
    "https://media.wired.com/photos/5cdefc28b2569892c06b2ae4/master/w_2560%2Cc_limit/Culture-Grumpy-Cat-487386121-2.jpg", 
    425, 
    'Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '122.21', 
    1, 
    'UL Professionally Grumpy', 
    'English'
  ),
  loanable: false,
  checkedout: false,
  id: 1
);

class BooksTileListScreen extends StatefulWidget {
  static final String routeName = 'booksTileList';

  @override
  _BooksTileListScreenState createState() => _BooksTileListScreenState();
}

class _BooksTileListScreenState extends State<BooksTileListScreen> {
  List<BookLibrary> allBooks = [bookRegular, bookOut, bookUnloanable];
  bool _isAscending = true;
  String sortParam = 'Author';
  List<BookLibrary> sortedBooks = [bookRegular, bookOut, bookUnloanable];

  @override
  Widget build(BuildContext context) {
    final Library library =  ModalRoute.of(context).settings.arguments;
    
    return DefaultTemplate(
      content: Container(
        child: Column(
          children: [
            filterSortBar(library.libraryName),
            Expanded(child: bookTileList())
          ],
        )
      ),
    );
  }

  Widget bookTileList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 3,
      itemBuilder: (context, index) {
        return bookTile(sortedBooks[index]);
      },
      separatorBuilder: (context, index) => const Divider()
    );
  }

  Widget bookTile(BookLibrary bookLib) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: bookLib.checkedout ? Colors.red : Colors.transparent
          ),
          color: bookLib.loanable ? Colors.transparent : Colors.grey[400]
        ),
        child: ListTile(
          title: Text(bookLib.book.title),
          subtitle: Text('${bookLib.book.author}'),
          trailing: bookTileEnd(bookLib),
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

  Widget bookTileEnd(BookLibrary bookLib) {
    if(sortParam != 'Author' && sortParam != 'Title' && bookLib.checkedout) {
      dynamic value = getValueFromSortParam(bookLib.book);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('$value', style: TextStyle(color: Colors.green)),
          Text('OUT', style: TextStyle(color: Colors.red))
        ]
      );
    } else if (bookLib.checkedout) {
      return Text('OUT', style: TextStyle(color: Colors.red));
    } else if (sortParam != 'Author' && sortParam != 'Title') {
      dynamic value = getValueFromSortParam(bookLib.book);
      return Text('$value', style: TextStyle(color: Colors.green));
    }

    return null;
  }

  Widget filterSortBar(String libraryName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Row(
        children: [
          Text(
            libraryName, 
            style: TextStyle(fontSize: 25)
          ),
          Spacer(flex: 1),
          ButtonBar(
            children: [
            filterDropDown(),
            sortDropDown()
          ])
        ]
      ),
    );
  }

  Widget filterDropDown() {
    var choices = <String>[
      'All','Unloanable', 'Loanable', 'Checked Out', 'Checked In'
    ];

    return PopupMenuButton(
      icon: Icon(Icons.filter_list), 
      onSelected: print, // TODO
      itemBuilder: (context) {
        return choices.map<PopupMenuItem<String>>((value) {
            return PopupMenuItem (
              child: Text(value),
              value: value,
            );
          }
        ).toList();
      }
    );
  }

  Widget sortDropDown() {
    var choices = <String>[
      'Author', 'Dewey Decimal', 'Pages', 'Title', 'Language'
    ];
    
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isAscending = !_isAscending;
          sortedBooks = sortedBooks.reversed.toList();
        });
      },
      child: PopupMenuButton(
        icon: _isAscending ? 
          Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward), 
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 'Dewey Decimal':
                sortedBooks.sort((a, b) 
                  => a.book.dewey.compareTo(b.book.dewey));
                break;
              case 'Pages':
                sortedBooks.sort((a, b) 
                  => a.book.pages.compareTo(b.book.pages));
                break;
              case 'Title':
                sortedBooks.sort((a, b) 
                  => a.book.title.compareTo(b.book.title));
                break;
              case 'Language':
                sortedBooks.sort((a, b) 
                  => a.book.lang.compareTo(b.book.lang));
                break;
              default: 
                sortedBooks.sort((a, b) 
                  => a.book.author.compareTo(b.book.author));
            }
            sortParam = value;
            _isAscending = true;
          });
        },
        itemBuilder: (context) {
          return choices.map<PopupMenuItem<String>>((value) {
              return PopupMenuItem (
                child: Text(value),
                value: value,
              );
            }
          ).toList();
        }
      ),
    );
  }
}