import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kRowContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(21.0),
  ),
  color: Color(0xFF273141),
);

final kPostNameTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);

final kPostEmailTextStyle = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.25,
  color: const Color(0xFF76ACFF),
);

final kPostGetNoteTextStyle = GoogleFonts.montserrat(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  color: Colors.white,
);

final kPostTimeTextStyle = GoogleFonts.montserrat(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);
