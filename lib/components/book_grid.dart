import 'package:flutter/material.dart';
import '../models/bookLibrary.dart';
import '../screens/single_book_screen.dart';

class BookGrid extends StatelessWidget {
  final Axis scrollDirection;
  final int bookCount;
  final int crossAxisCount;
  final String title;
  final BookLibrary bookLibrary;

  BookGrid({
    this.bookLibrary,
    this.crossAxisCount = 5, 
    @required this.title,
    @required this.bookCount, 
    @required this.scrollDirection
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 35),),
        ),
        cardGrid(context, bookLibrary),
      ],
    );
  }

  Widget cardGrid(BuildContext context, BookLibrary bookLibrary) {
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
          child: bookCard(context, bookLibrary) 
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