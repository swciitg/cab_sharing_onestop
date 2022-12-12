import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

const kRowContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(21.0),
  ),
  color: kCommonBoxBackground,
);

const kRowContainerDecorationMyPost = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(21.0),
  ),
  color: kFloatingButtonColor,
);

final kPostNameTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);

final kPostNameTextStyleMyPost = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.black,
);

final kPostEmailTextStyle = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.25,
  color: kFloatingButtonColor,
);

final kPostEmailTextStyleMyPost = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.25,
  color: Colors.black,
);

final kPostGetNoteTextStyle = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  color: Colors.white,
);

final kPostGetNoteTextStyleMyPost = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.4,
  color: Colors.black,
);

final kPostTimeTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);

final kPostTimeTextStyleMyPost = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.black,
);
