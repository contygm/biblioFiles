import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/home_tile.dart';
import '../templates/default_template.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  Widget addBookBtn(BuildContext context) {
    return Container(
        height: 100.0,
        width: 100.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.add, size: 40.0),
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
      content: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HomeTile(
                  title: 'Shelves', 
                  icon: FontAwesomeIcons.leanpub, 
                  routeName: 'shelves'
                ),
                HomeTile(
                  title: 'Unpack', 
                  icon: FontAwesomeIcons.boxOpen, 
                  routeName: 'unpack'
                )
              ],
            ),
          SizedBox(height: 30),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HomeTile(
                  title: 'Libraries', 
                  icon: FontAwesomeIcons.clone,
                  routeName: 'libraries',
                ),
                HomeTile(
                  title: 'Checkout', 
                  icon: FontAwesomeIcons.tasks,
                  routeName: 'checkout',
                )
              ]
            ),
          
        ]
      ),
    ); 
  } 
}