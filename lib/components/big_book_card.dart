import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';


class BigBookCard extends StatelessWidget {
  final BookLibrary bookInLib = BookLibrary(
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
    return Card(
      child: Center(
        child: Column(
          children: [
            Image(image: NetworkImage(bookInLib.book.bookImg))
          ]
        ),
      ),
    );
  }
}