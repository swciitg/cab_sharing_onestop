import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final titleStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: kGreyTextColor,
);

const commonBoxDecoration = BoxDecoration(
    color: kCommonBoxBackground,
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
  color: kGreyTextColor,
);

const hintStyle = TextStyle(
  color: kHintTextColor,
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

final timePeriodStyle = GoogleFonts.montserrat(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final iconMap = {
  'Campus': const Icon(
    Icons.school,
    color: Colors.white,
  ),
  'Airport': const Icon(
    Icons.airplanemode_active_outlined,
    color: Colors.white,
  ),
  'Railway Station': const Icon(
    Icons.directions_railway,
    color: Colors.white,
  )
};
