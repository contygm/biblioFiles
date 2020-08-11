import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final Color darkGreen = Color(0xFF166417);
  static final Color yellow = Color(0xFFF9A620);
  static final Color green = Color(0xFF26a96c);
  static final Color lightGreen = Color(0xFF48d594);
  static final Color mediumGrey = Color(0xFF585563);
  static final Color darkGrey = Color(0xFF495159);
  static final Color offWhite = Color(0xFFF5F5F5);
  
  static final TextStyle defaultFont = GoogleFonts.robotoSlab();

  static final TextStyle header1Style = headerFont(
    textStyle: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    )
  );

  static final TextStyle header2Style = headerFont(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: green,
    )
  );
  static final TextStyle header2DarkGreenStyle = headerFont(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: darkGreen,
    )
  );

  static final TextStyle header3Style = headerFont(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: green,
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
      color: offWhite,
      fontSize: 30,
      fontStyle: FontStyle.italic 
    )
  );

  static final TextStyle darkGreyMediumText = textFont(
    textStyle: TextStyle(
      color: darkGrey,
      fontSize: 20,
    )
  );

  static final TextStyle darkGreenMediumText = textFont(
    textStyle: TextStyle(
      color: darkGreen,
      fontSize: 20,
    )
  );

  static final TextStyle greenMediumText = textFont(
    textStyle: TextStyle(
      color: green,
      fontSize: 20,
    )
  );

  static final TextStyle greenText = textFont(
    textStyle: TextStyle(
      color: green,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    )
  );

  static final TextStyle bigButtonLabel = textFont(
    textStyle: TextStyle(
      color: offWhite,
      fontSize: 18,
    )
  );

  static final TextStyle smallWhiteButtonLabel = textFont(
    textStyle: TextStyle(
      color: offWhite,
      fontSize: 15,
    )
  );
  static final TextStyle smallWhiteBoldButtonLabel = textFont(
    textStyle: TextStyle(
      color: offWhite,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    )
  );

  static final TextStyle mediumWhiteButtonLabel = textFont(
    textStyle: TextStyle(
      color: offWhite,
      fontSize: 12,
    )
  );

  static final TextStyle smallGreenButtonLabel = textFont(
    textStyle: TextStyle(
      color: green,
      fontSize: 15,
    )
  );

  static final TextStyle smallDarkGreenButtonLabel = textFont(
    textStyle: TextStyle(
      color: darkGreen,
      fontSize: 15,
    )
  );
  static final TextStyle smallRedButtonLabel = textFont(
    textStyle: TextStyle(
      color: Colors.red,
      fontSize: 15,
    )
  );

  static final TextStyle smallerRedButtonLabel = textFont(
    textStyle: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    )
  );

  static final TextStyle bookTileTitle = textFont(
    textStyle: TextStyle(
      color: green,
      fontSize: 14,
    )
  );

  static final TextStyle bookTileAuthor = textFont(
    textStyle: TextStyle(
      color: darkGreen,
      fontSize: 12,
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