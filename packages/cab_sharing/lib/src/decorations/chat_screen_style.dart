import 'package:cab_sharing/src/decorations/colors.dart';
import 'package:flutter/material.dart';

const _font='Montserrat';
const sentBoxDecoration = BoxDecoration(
    color: kSentBoxColor,
    borderRadius: BorderRadius.all(Radius.circular(10)));

const receivedBoxDecoration = BoxDecoration(
    color: kReceiveBoxColor,
    borderRadius: BorderRadius.all(Radius.circular(10)));

const nameStyle = TextStyle(
  fontFamily: _font,
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
  color: Colors.white,
);

const chatTextStyle = TextStyle(
  fontFamily: _font,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  color: Colors.white,
);

const chatBoxEmailStyle = TextStyle(
  fontFamily: _font,
  fontSize: 10.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
  color: Colors.white,
);
