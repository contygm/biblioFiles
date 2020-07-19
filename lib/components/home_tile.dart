import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO title
// TODO icon
class HomeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(        
        border: Border.all(
          color: Colors.green,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.bookReader, 
              size: 100, 
              color: Colors.green
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "BiblioFiles",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}