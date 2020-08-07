import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';

BookLibrary bookRegular = BookLibrary(
  book: Book(
    "https://media.wired.com/photos/5cdefc28b2569892c06b2ae4/master/w_2560%2Cc_limit/Culture-Grumpy-Cat-487386121-2.jpg", 
    425, 
    'Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '122.21', 
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
    425, 
    'Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '122.21', 
    1, 
    'O - Professionally Grumpy', 
    'English'
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
  bool _isAscending = true;
  List<BookLibrary> allBooks = [bookRegular, bookOut, bookUnloanable];

  @override
  Widget build(BuildContext context) {
    final Library library =  ModalRoute.of(context).settings.arguments;
    
    return DefaultTemplate(
      content: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    library.libraryName, 
                    style: TextStyle(fontSize: 25)
                  ),
                  ButtonBar(children: [
                    DropdownButton(
                      icon: Icon(Icons.filter_list), 
                      iconSize: 24, 
                      onChanged: (value) {
                        
                      },
                      underline: Container(color: Colors.transparent),
                      items: ['Filter 1', 'Filter 2', 'Filter 3']
                        .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem (
                            child: Text(value),
                            value: value,
                          );
                        }
                      ).toList(),
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                          setState(() {
                            _isAscending = !_isAscending;
                          });
                        },
                      child: DropdownButton(
                        icon: _isAscending ? 
                        Icon(Icons.arrow_upward) : Icon(Icons.arrow_downward), 
                        iconSize: 24, 
                        onChanged: (value) {
                          setState(() {
                            // _isAscending = !_isAscending;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _isAscending = !_isAscending;
                          });
                        },
                        underline: Container(
                          // height: 2,
                          color: Colors.transparent,
                        ),
                        items: ['Sort 1', 'Sort 2', 'Sort 3']
                          .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem (
                              child: Text(value),
                              value: value,
                            );
                          }
                        ).toList(),
                      ),
                    )
                  ])
                ]
              ),
            ),
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
        return bookTile(allBooks[index]);
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
          color: bookLib.loanable ? Colors.transparent : Colors.grey
        ),
        child: ListTile(
          title: Text(bookLib.book.title),
          subtitle: Text('${bookLib.book.author}'),
          trailing: bookLib.checkedout ? 
            Text('OUT', style: TextStyle(color: Colors.red)) 
            : null,
        ),
    );
  }
}