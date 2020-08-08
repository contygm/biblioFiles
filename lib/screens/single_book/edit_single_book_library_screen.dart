import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../templates/default_template.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../models/bookLibrary.dart';
import 'single_book_screen.dart';

class LibraryBookCombined {
  int libid;
  int bookid;

  LibraryBookCombined(this.libid, this.bookid);
}

class EditLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new EditLibrary());
  }
}

class EditLibrary extends StatefulWidget {
  @override
  _EditLibraryState createState() => _EditLibraryState();
}

class _EditLibraryState extends State<EditLibrary> {
  Library selectedLibrary;
  @override
  void initState() {
    super.initState();
    getLibraries();
  }

  List<Library> finalLibraries = [];
  bool lookLibrary = false;
  void getLibraries() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    List<Library> libraries = await callGetLibraries(uid);
    setState(() {
      lookLibrary = true;
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    final BookLibrary book = ModalRoute.of(context).settings.arguments;
    if (lookLibrary == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      if (finalLibraries.isNotEmpty) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Change Book Location', style: TextStyle(fontSize: 35)),
              DropdownButtonFormField<Library>(
                  decoration: InputDecoration(labelText: 'Select a Library'),
                  value: selectedLibrary,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLibrary = newValue;
                    });
                  },
                  items: finalLibraries
                      .map((item) => DropdownMenuItem<Library>(
                            child: Text(item.libraryName),
                            value: item,
                          ))
                      .toList()),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RaisedButton(onPressed: () async {
                  var libBookId = LibraryBookCombined(selectedLibrary.id, book.id);
                     
                        //submit info to db and navigate to libraries
                    await updateBooksLibrary(libBookId);
                final message =
                    SnackBar(content: Text('Changes have been made!'));
                Scaffold.of(context).showSnackBar(message);  
                }, child: Text('Save')),
                RaisedButton(
                    onPressed: ()  {
              Navigator.of(context)
                    .pushNamed(SingleBookScreen.routeName, arguments: book);
                    },
                    child: Text('View Book'))
              ]),
            ],
          ),
        );
      }
    }
  }
}
