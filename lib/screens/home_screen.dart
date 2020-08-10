import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/home_tile.dart';
import '../styles.dart';
import '../templates/default_template.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  Widget addBookBtn(BuildContext context) {
    return Container(
        height: 75.0,
        width: 75.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Styles.darkGrey,
              child: Icon(Icons.add, size: 30.0, color: Styles.offWhite),
              tooltip: 'Add a Book',
              onPressed: () => Navigator.of(context).pushNamed( 'addBook' ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      floatingAction: addBookBtn(context),
      floatingActionLocation: FloatingActionButtonLocation.centerFloat,
      content: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HomeTile(
              title: 'Shelves', 
              icon: FontAwesomeIcons.leanpub, 
              routeName: 'shelvesScreen',
              themeColor: Styles.green,

            ),
            HomeTile(
              title: 'Unpack', 
              icon: FontAwesomeIcons.boxOpen, 
              routeName: 'unpack',
              themeColor: Styles.darkGreen
            ),
            HomeTile(
              title: 'Libraries', 
              icon: FontAwesomeIcons.warehouse,
              routeName: 'libraries',
              themeColor: Styles.green
            ),
            HomeTile(
              title: 'Checkout', 
              icon: FontAwesomeIcons.tasks,
              routeName: 'checkout',
              themeColor: Styles.darkGreen
            )
          ]
        ),
      ),
    ); 
  } 
}