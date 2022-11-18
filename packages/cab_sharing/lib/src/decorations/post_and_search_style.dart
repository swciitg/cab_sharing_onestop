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
    borderRadius: BorderRadius.all(
        Radius.circular(21)
    )
);

final secondStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);