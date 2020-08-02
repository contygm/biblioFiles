import 'package:flutter/material.dart';
import '../models/book.dart';

class BookGrid extends StatelessWidget {
  final Axis scrollDirection;
  final int bookCount;
  final int crossAxisCount;
  final String title;

  BookGrid({
    this.crossAxisCount = 5, 
    @required this.title,
    @required this.bookCount, 
    @required this.scrollDirection
  });

  // REMOVE this
  final Book bookExample = Book(
    "assets/grumpy-cat.jpg", 
    425, 
    'Sir Chonk', 
    '1234567890123', 
    '1234567890', 
    '122.21', 
    1, 
    'Professionally Grumpy', 
    'English'
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 35),),
        ),
        cardGrid(context),
      ],
    );
  }

  Widget cardGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      itemCount: bookCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, 
      ), 
      itemBuilder: (context, index) {
        return Center(
          child: bookCard(context, bookExample)
        );
      }
    );
  }

  Widget bookCard(BuildContext context, Book book) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(book.bookImg),
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
              Text("${book.bookTitle}"),
              Divider(),
              Text("by ${book.author}")
            ],
          )
        ),
      ),
    );
  }
}

// Opacity(opacity: 0.99, child: Image.network(movie.image, fit: BoxFit.cover)),
// Opacity(opacity: 0.5, child: AssetImage(book.bookImg)),