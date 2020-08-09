import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles.dart';

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return logoTitle(context); 
  }

  Widget logoTitle(BuildContext context) {
    return Center(
      child: Column(
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
              style: Styles.header1Style,
            ),
          )
        ]
      ),
    );
  }
}