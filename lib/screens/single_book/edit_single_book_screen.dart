import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import 'single_book_screen.dart';

class EditBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new EditBook());
  }
}

class EditBook extends StatefulWidget {
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _key = GlobalKey<FormState>();
  List<bool> values = [true, false];

  @override
  Widget build(BuildContext context) {
    final BookLibrary book = ModalRoute.of(context).settings.arguments;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Styles.green),
                  helperText: '(read only)',
                  helperStyle: TextStyle(color: Styles.mediumGrey),
                ),
                initialValue: '${book.book.title}',
                readOnly: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Author',
                  labelStyle: TextStyle(color: Styles.green),
                  helperText: '(read only)',
                  helperStyle: TextStyle(color: Styles.mediumGrey),
                ),
                initialValue: '${book.book.author}',
                readOnly: true
              ),
              SwitchListTile(
                title: Text('Currently Reading', 
                  style: TextStyle(color: Styles.green)),
                value: book.currentlyreading,
                activeColor: Styles.green,
                onChanged: (newValue) {
                  setState(() {
                    book.currentlyreading = newValue;
                  });
                }
              ),
              SwitchListTile(
                title: Text('Checked Out',
                  style: TextStyle(color: Styles.green)),
                value: book.checkedout,
                activeColor: Styles.green,
                onChanged: (newValue) {
                  setState(() {
                    book.checkedout = newValue;
                  });
                }
              ),
              SwitchListTile(
                title: Text('Loanable Book', 
                  style: TextStyle(color: Styles.green)
                ),
                value: book.loanable,
                activeColor: Styles.green,
                onChanged: (newValue) {
                  setState(() {
                    book.loanable = newValue;
                  });
                }
              ),
              DropdownButtonFormField(
                iconEnabledColor: Styles.green,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Styles.green),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.darkGreen
                    )
                  ),
                ),
                value: book.rating,
                onChanged: (newValue) {
                  setState(() {
                    book.rating = newValue;
                  });
                },
                items: <int>[1, 2, 3, 4, 5]
                  .map((item) => DropdownMenuItem<int>(
                        value: item,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(item, (index) {
                            return Icon(Icons.star, color: Styles.yellow);
                          })
                        )
                      ))
                  .toList()
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  labelStyle: TextStyle(color: Styles.green),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.darkGreen
                    )
                  )
                ),
                onChanged: (value) {
                  setState(() {
                    book.notes = value;
                  });
                },
              ),
              buttonRow(book)
            ]
          ),
        )
      ),
    );
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
              onPressed: () {
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
                //submit info to db and navigate to libraries
                await updateLibraryBook(book);
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
