import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextFieldFormContainerDecoration = BoxDecoration(
    color: Color.fromRGBO(39, 49, 65, 1),
    borderRadius: BorderRadius.all(Radius.circular(21)));

final kTextFieldFormTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

const kTextFieldFormDecoration = InputDecoration(
  hintText: "",
  hintStyle: TextStyle(
    color: Colors.white60,
  ),
);

const kSignUpTextContainerDecoration = BoxDecoration(
    color: Color.fromRGBO(118, 172, 255, 1),
    borderRadius: BorderRadius.all(Radius.circular(16)));
final kSignUpTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

final kAlreadyHaveAnAccountTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

final kSignInTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color.fromRGBO(118, 172, 255, 1),
);
