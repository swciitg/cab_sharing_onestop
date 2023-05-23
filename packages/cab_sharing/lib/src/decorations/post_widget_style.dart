import 'package:flutter/material.dart';

import 'colors.dart';
const _font='Montserrat';
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

const kPostNameTextStyle = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);

const kPostNameTextStyleMyPost = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.black,
);

const kPostEmailTextStyle = TextStyle(
  fontFamily: _font,
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.25,
  color: kFloatingButtonColor,
);

const kPostEmailTextStyleMyPost = TextStyle(
  fontFamily: _font,
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.25,
  color: Colors.black,
);

const kPostGetNoteTextStyle = TextStyle(
  fontFamily: _font,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
  color: Colors.white,
);

const kPostGetNoteTextStyleMyPost = TextStyle(
  fontFamily: _font,
  fontSize: 12.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.4,
  color: Colors.black,
);

const kPostTimeTextStyle = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.white,
);

const kPostTimeTextStyleMyPost = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Colors.black,
);
