import 'package:cab_sharing/src/decorations/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const sentBoxDecoration = BoxDecoration(
    color: kSentBoxColor,
    borderRadius: BorderRadius.all(Radius.circular(10)));

const receivedBoxDecoration = BoxDecoration(
    color: kReceiveBoxColor,
    borderRadius: BorderRadius.all(Radius.circular(10)));

final nameStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: Colors.white,
);

final chatTextStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: Colors.white,
);
