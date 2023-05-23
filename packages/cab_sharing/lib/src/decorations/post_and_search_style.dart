import 'package:flutter/material.dart';



import 'colors.dart';
const _font='Montserrat';
const titleStyle = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: kGreyTextColor,
);

const commonBoxDecoration = BoxDecoration(
    color: kCommonBoxBackground,
    borderRadius: BorderRadius.all(Radius.circular(21)));

const secondStyle = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: Colors.white,
);

const counterStyle = TextStyle(
  fontFamily: _font,
  fontSize: 10.0,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
  color: kGreyTextColor,
);

const hintStyle = TextStyle(
  color: kHintTextColor,
);

const errorStyle = TextStyle(
  fontFamily: _font,
  color: Colors.redAccent,
  fontSize: 10,
  fontWeight: FontWeight.w400,
);

const dateTimeWheelStyle = TextStyle(
  fontFamily: _font,
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const timePeriodStyle = TextStyle(
  fontFamily: _font,
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
