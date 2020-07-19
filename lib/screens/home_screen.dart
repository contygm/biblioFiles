import 'package:flutter/material.dart';
import '../templates/default_template.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Home Page'),
          Row(
            children: <Widget>[
              // TODO
            ],
          ),
          Row(
            children: <Widget>[
              //TODO
            ]
          )
        ]
      ),
    ); 
  } 
}