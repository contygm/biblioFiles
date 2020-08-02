import 'package:flutter/material.dart';
import '../components/book_grid.dart';
import '../templates/default_template.dart';


// TODO grid
class ShelvesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
