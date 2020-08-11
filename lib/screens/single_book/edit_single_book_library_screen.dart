import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../templates/default_template.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../models/bookLibrary.dart';
import '../../styles.dart';
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
    } else if (finalLibraries.isNotEmpty){
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Change Book Location', style: Styles.header2Style),
            DropdownButtonFormField<Library>(
              decoration: InputDecoration(
                labelText: 'Select a Library',
              ),
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
                .toList()
            ),
            buttonRow(book)
          ],
        ),
      );
    } else {
      return Container(child: Text('You don\'t have any libraries yet!', 
        style: Styles.header2Style));
    }
  }

    Widget buttonRow(BookLibrary book) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
          ButtonTheme(
            buttonColor: Styles.darkGreen,
            minWidth: (MediaQuery.of(context).size.width * 0.25),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
              onPressed: ()  {
                Navigator.of(context)
                .pushNamed(SingleBookScreen.routeName, arguments: book);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: FaIcon(FontAwesomeIcons.book, color: Styles.offWhite)
                  ),
                  Text('View book', 
                    style: Styles.smallWhiteButtonLabel,
                    textAlign: TextAlign.center
                  ),
                ],
              )
            )
          ),
          ButtonTheme(
            buttonColor: Styles.yellow,
            minWidth: (MediaQuery.of(context).size.width * 0.25),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
              onPressed: () async {
                var libBookId = LibraryBookCombined(
                    selectedLibrary.id, book.id);
                //submit info to db and navigate to libraries
                await updateBooksLibrary(libBookId);
                final message =
                  SnackBar(content: Text('Changes have been made!'));
                Scaffold.of(context).showSnackBar(message);  
              },
              child: Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FaIcon(FontAwesomeIcons.solidSave, 
                      color: Styles.offWhite, 
                      size: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Text('Save', 
                    style: Styles.smallWhiteBoldButtonLabel,
                    textAlign: TextAlign.center
                  ),
                ],
              )
            )
          )
        ]
      ),
    );
  }
}
