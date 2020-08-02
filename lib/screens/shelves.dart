import 'package:flutter/material.dart';
import '../components/book_grid.dart';
import '../models/book.dart';

import '../models/bookLibrary.dart';
import '../templates/default_template.dart';

// TODO shelf list
// TODO multiple shelves
class ShelvesScreen extends StatelessWidget {
  static const routeName = 'shelvesScreen';
  List<String> libraries = ['Currently Reading', 'Checked Out', 'Another One'];
  // REMOVE this
  final BookLibrary bookLibrary = BookLibrary(
    book: Book(
      "https://media.wired.com/photos/5cdefc28b2569892c06b2ae4/master/w_2560%2Cc_limit/Culture-Grumpy-Cat-487386121-2.jpg", 
      425, 
      'Sir Chonk', 
      '1234567890123', 
      '1234567890', 
      '122.21', 
      1, 
      'Professionally Grumpy', 
      'English'
    ),
    notes: 'Excellent resources for how to be grumpy',
    private: false,
    loanable: true,
    rating: 4,
    currentlyreading: true,
    checkedout: false,
    unpacked: false,
    id: 1
  );

  @override
  Widget build(BuildContext context) {
    // TODO pass in books from DB and library title
    return DefaultTemplate(
      content: BookGrid(
        bookLibrary: bookLibrary,
        crossAxisCount: 3, 
        title: 'Library Title',
        bookCount: 100, 
        scrollDirection: Axis.vertical
      )
    );
  }
}
