import 'package:flutter/material.dart';
import '../components/book_grid.dart';
import '../components/floating_back_button.dart';
import '../templates/default_template.dart';
import '../db/databaseops.dart';
import '../models/library.dart';
import 'libraries_screen.dart'; 

int libraryId;
String libraryname; 
class LibraryBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LibraryArgs librarydeets = ModalRoute.of(context).settings.arguments;
    libraryId = librarydeets.id;
    libraryname = librarydeets.name; 
    return DefaultTemplate(content: LoadBooksLibrary(),
    floatingAction: FloatingBackButton(context));
  }
}

class LoadBooksLibrary extends StatefulWidget {
  @override
  _LoadBooksLibraryState createState() => _LoadBooksLibraryState();
}

class _LoadBooksLibraryState extends State<LoadBooksLibrary> {
  @override
  void initState() {
    super.initState();
    getBooksinLibrary();
  }

  List<dynamic> finalBooks = [];
  void getBooksinLibrary() async {
    var books = await callGetLibraryBooks(libraryId);
    setState(() {
      finalBooks = books;
    });
  }
  

  Widget build(BuildContext context) {
    if (finalBooks.isNotEmpty) {
       return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            height: 300,
            child: BookGrid(
                bookLibrary: finalBooks,
                crossAxisCount: 2,
                title: libraryname,
                bookCount: finalBooks.length,
                scrollDirection: Axis.horizontal),
          );
        },
        separatorBuilder: (context, index) => const Divider());
  }
    //otherwise print empty screen
    return Container(
        child: Column(
      children: [
        RaisedButton(
            child: Text('Add Book'),
            onPressed: () {
              Navigator.pushNamed(context, 'addBook');
            })
      ],
    ));
  }
}
