import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final Color blue = Color(0xFF00A1E4);
  static final Color pink = Color(0xFFe83f6f);
  static final Color yellow = Color(0xFFffbf00);
  static final Color green = Color(0xFF26a96c);
  static final Color darkGrey = Color(0xFF495159);
  static final Color offWhite = Color(0xFFF5F5F5);
  

  static final TextStyle header1Style = headerFont(
    textStyle: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    )
  );

  static final TextStyle homeTileStyle = headerFont(
    textStyle: TextStyle(
      fontSize: 25,
      color: offWhite,
    )
  );

  static final TextStyle welcomeMsg = textFont(
    textStyle: TextStyle(
      color: Styles.darkGrey,
      fontSize: 30,
      fontStyle: FontStyle.italic 
    )
  );

  static final TextStyle bigButtonLabel = textFont(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    )
  );
}

TextStyle headerFont({TextStyle textStyle}) {
  return GoogleFonts.lato(
    textStyle: textStyle
  );
}

TextStyle textFont({TextStyle textStyle}) {
  return GoogleFonts.robotoSlab(
    textStyle: textStyle
  );
}