import 'package:flutter/material.dart';

import '../models/bookLibrary.dart';
import '../screens/single_book/single_book_screen.dart';

class BookGrid extends StatelessWidget {
  final Axis scrollDirection;
  final int bookCount;
  final int crossAxisCount;
  final String title;
  final Widget titleWidget;
  final List<BookLibrary> bookLibrary;

  BookGrid(
      {this.bookLibrary,
      this.crossAxisCount = 5,
      this.titleWidget,
      this.title,
      @required this.bookCount,
      @required this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleWidget ?? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontSize: 35)
          ),
        ),
        Expanded(child: cardGrid(context, bookLibrary)),
      ],
    );
  }

  Widget cardGrid(BuildContext context, List<BookLibrary> bookLibrary) {
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        itemCount: bookCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemBuilder: (context, index) {
          return Center(child: bookCard(context, bookLibrary[index]));
        });
  }

  Widget bookCard(BuildContext context, BookLibrary bookLibrary) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
        .pushNamed(SingleBookScreen.routeName, arguments: bookLibrary);
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
                    Colors.black.withOpacity(0.3), BlendMode.dstATop)),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${bookLibrary.book.bookTitle}",
                textAlign: TextAlign.center,
              ),
              Divider(),
              Text("by ${bookLibrary.book.author}")
            ],
          )),
        ),
      ),
    );
  }
}
