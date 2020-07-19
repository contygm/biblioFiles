import 'package:flutter/material.dart';
import '../components/home_tile.dart';
import '../templates/default_template.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  Widget addBookBtn() {
    return Container(
        height: 100.0,
        width: 100.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.add, size: 40.0),
              tooltip: 'Add a Book',
              onPressed: () => print('ADD BOOK'),
            ),
          ),
        ),
      );
  }
  // TODO names and icons
  // TODO basic pages
  // TODO basic routes 

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      floatingAction: addBookBtn(),
      floatingActionLocation: FloatingActionButtonLocation.centerFloat,
      content: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HomeTile(),
                HomeTile()
              ],
            ),
          SizedBox(height: 30),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HomeTile(),
                HomeTile()
              ]
            ),
          
        ]
      ),
    ); 
  } 
}