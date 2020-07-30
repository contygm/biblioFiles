import 'package:flutter/material.dart';
import '../templates/default_template.dart';
import '../db/databaseops.dart';
import '../models/library.dart';

int libraryId;

class LibraryBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    libraryId = ModalRoute.of(context).settings.arguments;
    return DefaultTemplate(content: new LoadBooksLibrary());
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
    List<dynamic> books = await callGetLibraryBooks(libraryId);
    setState(() {
      finalBooks = books;
    });
  }

  Widget build(BuildContext context) {
    if (finalBooks.isNotEmpty) {
      return Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Add Book'),
              onPressed: () {
                //add book screen
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: finalBooks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Title: ${finalBooks[index].book.title}'),
                                  Text('Author: ${finalBooks[index].book.author}'),
                                  RaisedButton(
                                      onPressed: () {
                                        //delete book 
                                      },
                                      child: Text('Delete'))
                                ])
                          ],
                        ),
                      );
                    })),
          ],
        ),
      );
    }
    //otherwise print empty screen
    return Container(
        child: Column(
      children: [
        RaisedButton(
            child: Text('Add Book'),
            onPressed: () {
              //add book screen
            })
      ],
    ));
  }
}
