import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles.dart';

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dimension =MediaQuery.of(context).size.width * 0.35;
    return Stack(
      children: [
        background(context, dimension), logoTitle(context)
      ]);
  }

  Widget background(BuildContext context, double dimension) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Styles.green,
              height: dimension,
              width: dimension,
            ),
            Container(
              color: Styles.yellow,
              height: dimension,
              width: dimension
            )
          ]
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Styles.pink,
              height: dimension,
              width: dimension,
            ),
            Container(
              color: Styles.blue,
              height: dimension,
              width: dimension,
            )
          ]
        ),
      ],
    );
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