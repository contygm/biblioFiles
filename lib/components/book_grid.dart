import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/bookLibrary.dart';
import '../screens/single_book_screen.dart';

class BookGrid extends StatelessWidget {
  final Axis scrollDirection;
  final int bookCount;
  final int crossAxisCount;
  final String title;
  final List<Book> books;

  BookGrid({
    this.books,
    this.crossAxisCount = 5, 
    @required this.title,
    @required this.bookCount, 
    @required this.scrollDirection
  });

  // REMOVE this
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 35),),
        ),
        cardGrid(context, books),
      ],
    );
  }

  Widget cardGrid(BuildContext context, List<Book> books) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      // TODO replace with books count from DB
      itemCount: bookCount, 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, 
      ), 
      itemBuilder: (context, index) {
        return Center(
          // TODO replace with books[index]
          child: bookCard(context, bookInLib) 
        );
      }
    );
  }

  Widget bookCard(BuildContext context, BookLibrary bookLibrary) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          SingleBookScreen.routeName, 
          arguments: bookLibrary
        );
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(bookLibrary.book.bookImg),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), 
                BlendMode.dstATop
              )
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${bookLibrary.book.bookTitle}", 
                  textAlign: TextAlign.center
                ),
                Divider(),
                Text("by ${bookLibrary.book.author}")
              ],
            )
          ),
        ),
      ),
    );
  }
}