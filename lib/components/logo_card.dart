import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.bookReader, 
            size: 200, 
            color: Colors.green
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "BiblioFiles",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ]
      ),
    );
  }
}