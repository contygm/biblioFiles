import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles.dart';

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.bookReader, 
          size: MediaQuery.of(context).size.width * 0.4, 
          color: Colors.white
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "BiblioFiles",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.14,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        )
      ]
    );
  }
}