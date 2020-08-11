import 'package:biblioFiles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../templates/default_template.dart';

class SingleBookScreen extends StatefulWidget {
  static const routeName = 'singleBookScreen';

  @override
  _SingleBookScreenState createState() => _SingleBookScreenState();
}

class _SingleBookScreenState extends State<SingleBookScreen> {
  bool _isSmall = true;
  @override
  Widget build(BuildContext context) {
    final BookLibrary bookLibrary = ModalRoute.of(context).settings.arguments;

    // TODO lil box shadow
    return DefaultTemplate(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              // side: BorderSide(color: themeColor, width: 5.0)
            ),
          elevation: 4,
          child: _isSmall
            ? smallInfo(context, bookLibrary)
            : bigInfo(context, bookLibrary)),
      ));
  }

  Widget smallInfo(BuildContext context, BookLibrary bookLibrary) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      (bookLibrary.book.bookImg.length > 1 ? 
        Image(
          fit: BoxFit.scaleDown,
          image: NetworkImage(bookLibrary.book.bookImg),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
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
      Divider(color: Colors.transparent),
      ListTile(
        leading: Text('Title:', style: Styles.greenText),
        title: Text(bookLibrary.book.title)
      ),
      ListTile(
        leading: Text('Author:', style: Styles.greenText),
        title: Text(bookLibrary.book.author)
      ),
      IconButton(
        icon: Icon(Icons.expand_more, size: 30),
        onPressed: () {
          setState(() {
            _isSmall = !_isSmall;
          });
        }
      ),
    ]);
  }

  Widget bigInfo(BuildContext context, BookLibrary bookLibrary) {
    return ListView(
      shrinkWrap: true,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: (bookLibrary.book.bookImg.length > 1 ? 
            Image(
              fit: BoxFit.cover,
              image: NetworkImage(bookLibrary.book.bookImg),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.5,
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
        Divider(color: Colors.transparent),
        ListTile(
          leading: Text('Title:', style: Styles.greenText),
          title: Text(bookLibrary.book.title)
        ),
        ListTile(
          leading: Text('Author:', style: Styles.greenText),
          title: Text(bookLibrary.book.author)
        ),
        ListTile(
          leading: Text('ISBN 10:', style: Styles.greenText),
          title: Text(bookLibrary.book.isbn_10.length < 1 ? '-' : bookLibrary.book.isbn_10)
        ),
        ListTile(
          leading: Text('ISBN 13:', style: Styles.greenText),
          title: Text(bookLibrary.book.isbn_13.length < 1 ? '-' : bookLibrary.book.isbn_13)
        ),
        ListTile(
          leading: Text('Dewey Decimal:', style: Styles.greenText),
          title: Text((bookLibrary.book.deweyd.length < 1 ? '-' : bookLibrary.book.deweyd))
        ),
        ListTile(
          leading: Text('Pages:', style: Styles.greenText),
          title: Text((bookLibrary.book.pageCount == null || bookLibrary.book.pageCount == 0) ? '-' : '${bookLibrary.book.pageCount}')
        ),
        ListTile(
          leading: Text('Language:', style: Styles.greenText),
          title: Text((bookLibrary.book.bookLang.length < 1 ? '-' : bookLibrary.book.bookLang))
        ),
        ListTile(
          leading: Text('Checked Out:', style: Styles.greenText),
          title: Text(bookLibrary.checkedout ? 'Yes' : 'No')
        ),
        ListTile(
          leading: Text('Currently Reading:', style: Styles.greenText),
          title: Text(bookLibrary.currentlyreading ? 'Yes' : 'No')
        ),
        ListTile(
          leading: Text('Loanable:', style: Styles.greenText),
          title: Text(bookLibrary.loanable ? 'Yes' : 'No')
        ),
        ListTile(
          leading: Text('Rating:', style: Styles.greenText),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Icon(
                index < (bookLibrary.rating ?? 0) ? Icons.star : Icons.star_border,
              );
            })
          )
        ),
        ListTile(
          leading: Text('Notes:', style: Styles.greenText),
          title: Text(bookLibrary.notes ?? '-')
        ),
        Divider(color: Colors.transparent),
        Padding(
          padding: const EdgeInsets.all(10.0),
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
                    Navigator.pushNamed(context, 'editBook', arguments: bookLibrary);
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: FaIcon(FontAwesomeIcons.book, color: Styles.offWhite)
                      ),
                      Text('Update\nBook', 
                        style: Styles.smallWhiteButtonLabel,
                        textAlign: TextAlign.center
                      ),
                    ],
                  )
                )
              ),
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
                    Navigator.pushNamed(context, 'editBookLibrary',
                        arguments: bookLibrary);
                  },
                  child: Row(
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FaIcon(FontAwesomeIcons.warehouse, 
                          color: Styles.offWhite, 
                          size: MediaQuery.of(context).size.width * 0.05),
                      ),
                      Text('Update\nLibrary', 
                        style: Styles.smallWhiteButtonLabel,
                        textAlign: TextAlign.center
                      ),
                    ],
                  )
                )
              )
            ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                buttonColor: Colors.red,
                minWidth: (MediaQuery.of(context).size.width * 0.25),
                height: (MediaQuery.of(context).size.width * 0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: RaisedButton(
                  elevation: 3,
                onPressed: () async {
                  await callDeleteLibraryBook(bookLibrary.id);
                    Navigator.pushNamed(context, 'home');
                      
                },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FaIcon(FontAwesomeIcons.trash, color: Styles.offWhite),
                  ),
                  Text('Delete\nBook', 
                    textAlign: TextAlign.center,
                    style: Styles.smallWhiteButtonLabel),
                ],
              ))),
            ],
          ),
        ),
      IconButton(
        icon: Icon(Icons.expand_less),
        onPressed: () {
          setState(() {
            _isSmall = !_isSmall;
          });
        })
      ],
    );
  }
}
