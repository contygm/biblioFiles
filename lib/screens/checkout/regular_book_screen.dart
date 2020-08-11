import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../models/library.dart'; 
import '../../styles.dart';
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';

class RegularBookScreen extends StatefulWidget {
  final BookLibrary bookLibrary;
  final Library lib;
  RegularBookScreen(this.lib, this.bookLibrary);

  @override
  _RegularBookScreenState createState() => _RegularBookScreenState();
}

class _RegularBookScreenState extends State<RegularBookScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: (widget.bookLibrary.book.bookImg.length > 1 ? 
              Image(
                fit: BoxFit.fill,
                image: NetworkImage(widget.bookLibrary.book.bookImg),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
              )
              : SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  color: Styles.darkGreen,
                  child: Icon(Icons.import_contacts, 
                    color: Styles.offWhite, 
                    size: 200),
                ),
              )),
          ),
          ListTile(
            leading: Text('Title:', style: Styles.greenMediumText),
            title: Text(widget.bookLibrary.book.title)
          ),
          ListTile(
            leading: Text('Author:', style: Styles.greenMediumText),
            title: Text(widget.bookLibrary.book.author)
          ),
          SwitchListTile(
              title: Text('Loanable', style: Styles.greenMediumText),
              value: widget.bookLibrary.loanable,
              activeColor: Styles.green,
              onChanged: (value) async {
                setState(() {
                  print('_loanable');
                  widget.bookLibrary.loanable = !widget.bookLibrary.loanable;
                });
                await updateLibraryBook(widget.bookLibrary);
              }),
          buttonRow()
        ]),
      ),
    );
  }

  Widget buttonRow() {
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
                    .pushNamed('checkoutForm', arguments: widget.bookLibrary);
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: FaIcon(FontAwesomeIcons.arrowAltCircleLeft, color: Styles.offWhite)
                  ),
                  Text('Checkout', 
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
              onPressed: () => Navigator.of(context).pushNamed(
                BooksTileListScreen.routeName,
                arguments: widget.lib),
              child: Row(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FaIcon(FontAwesomeIcons.check, 
                      color: Styles.offWhite, 
                      size: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Text('Done', 
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
