import 'package:flutter/material.dart';
import '../components/book_grid.dart';
import '../templates/default_template.dart';

// TODO shelf list
// TODO multiple shelves
class ShelvesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO pass in books from DB and library title
    return DefaultTemplate(
      content: BookGrid(
        crossAxisCount: 3, 
        title: 'Library Title',
        bookCount: 100, 
        scrollDirection: Axis.vertical
      )
    );
  }
}
