import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// signin.dart decoration
//added k in front of the name constants to make it easier to access

//TextfieldForm Form Style Property
final kTextFieldFormStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

//TextfieldForm Form Decoration Property
const kTextFieldFormDecoration = InputDecoration(
  hintText: "Enter Email",
  hintStyle: TextStyle(
    color: Colors.white60,
  ),
);

//Container parent to TextFieldForm Decoration
const kTextFieldFormContainerDecoration = BoxDecoration(
    color: Color.fromRGBO(39, 49, 65, 1),
    borderRadius: BorderRadius.all(Radius.circular(21)));

//Container parent to Sign in Text decoration
const kSignInContainerDecoration = BoxDecoration(
    color: Color.fromRGBO(118, 172, 255, 1),
    borderRadius: BorderRadius.all(Radius.circular(16)));

//Sign in text TextStyle
final kSignInTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

//No Account ? text TextStyle
final kNoAccountTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color(0xFFBDC7DC),
);

//Sign up text TextStsyle
final kSignUpTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: const Color.fromRGBO(118, 172, 255, 1),
);
