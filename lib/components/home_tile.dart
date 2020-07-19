import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Column(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.bookReader, 
            size: 100, 
            color: Colors.green
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "BiblioFiles",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green
              ),
            ),
          )
        ],
      ),
    );
  }
}