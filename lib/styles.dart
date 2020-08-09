import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final Color blue = Color(0xFF00A1E4);
  static final Color pink = Color(0xFFFF8484);
  static final Color yellow = Color(0xFFE2C044);
  static final Color green = Color(0xFF06D6A0);
  static final Color darkGrey = Color(0xFF495159);

  final TextStyle header1Style = headerFont(
    TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    )
  );
}

TextStyle headerFont(TextStyle textStyle) {
  return GoogleFonts.lato(
    textStyle: textStyle
  );
}

TextStyle textFont(TextStyle textStyle) {
  return GoogleFonts.robotoSlab(
    textStyle: textStyle
  );
}