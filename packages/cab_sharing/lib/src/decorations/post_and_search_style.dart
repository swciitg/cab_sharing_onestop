import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final titleStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

const commonBoxDecoration = BoxDecoration(
    color: Color.fromRGBO(39, 49, 65, 1),
    borderRadius: BorderRadius.all(Radius.circular(21)));

final secondStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

final counterStyle = GoogleFonts.montserrat(
  fontSize: 10.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

final hintStyle = TextStyle(
  color: Color.fromRGBO(79, 91, 108, 1.0),
);

final errorStyle = GoogleFonts.montserrat(
  color: Colors.redAccent,
  fontSize: 10,
  fontWeight: FontWeight.w400,
);

final dateTimeWheelStyle = GoogleFonts.montserrat(
fontSize: 18,
color: Colors.white,
fontWeight: FontWeight.bold,
);