import 'package:flutter/material.dart';
import '../../templates/default_template.dart';
import '../../models/bookLibrary.dart';

class RegularBookScreen extends StatelessWidget {
  final BookLibrary book;
  RegularBookScreen(this.book);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('REGULAR'),
      ),
    );
  }
}