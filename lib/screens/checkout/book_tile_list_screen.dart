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
  // keep track of sort order
  bool _isAscending = true;
  
  // keep track of sort param, default = Author
  String sortParam = 'Author';
  
  // this contains the original book list (used for filtering)
  List<BookLibrary> allBooks = [bookRegular, bookOut, bookUnloanable];
  
  // this will contain the sorted/filtered books
  List<BookLibrary> organizedBooks = [bookRegular, bookOut, bookUnloanable];

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
      itemCount: organizedBooks.length,
      itemBuilder: (context, index) {
        return bookTile(organizedBooks[index]);
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

  // determines the text for the right side of tile
  // based on sort and checkout statuses
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

  // screen's title bar that has buttons for filter and sort
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
            filterButton(),
            sortButton()
          ])
        ]
      ),
    );
  }

  Widget filterButton() {
    var choices = <String>[
      'All','Unloanable', 'Loanable', 'Checked Out', 'Checked In'
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
            return PopupMenuItem (
              child: Text(value),
              value: value,
            );
          }
        ).toList();
      }
    );
  }

  Widget sortButton() {
    var choices = <String>[
      'Author', 'Dewey Decimal', 'Pages', 'Title', 'Language'
    ];
    
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isAscending = !_isAscending;
          organizedBooks = organizedBooks.reversed.toList();
        });
      },
      child: PopupMenuButton(
        icon: _isAscending ? 
          Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward), 
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 'Dewey Decimal':
                organizedBooks.sort((a, b) 
                  => a.book.dewey.compareTo(b.book.dewey));
                break;
              case 'Pages':
                organizedBooks.sort((a, b) 
                  => a.book.pages.compareTo(b.book.pages));
                break;
              case 'Title':
                organizedBooks.sort((a, b) 
                  => a.book.title.compareTo(b.book.title));
                break;
              case 'Language':
                organizedBooks.sort((a, b) 
                  => a.book.lang.compareTo(b.book.lang));
                break;
              default: 
                organizedBooks.sort((a, b) 
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