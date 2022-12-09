import 'package:cab_sharing/src/decorations/post_widget_style.dart';
import 'package:flutter/material.dart';

SnackBar getSnackbar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: kPostGetNoteTextStyle,
    ),
  );
}