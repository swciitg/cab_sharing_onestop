import 'package:cab_sharing/src/decorations/post_widget_style.dart';
import 'package:flutter/material.dart';

SnackBar getSnackBar(String message) {
  return SnackBar(
    duration: const Duration(seconds: 1, milliseconds: 500),
    content: Text(
      message,
      style: kPostGetNoteTextStyle,
    ),
  );
}