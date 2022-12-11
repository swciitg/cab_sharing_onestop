import 'package:flutter/material.dart';

import '../decorations/post_widget_style.dart';

SnackBar getSnackBar(String message) {
  return SnackBar(
    duration: const Duration(seconds: 1, milliseconds: 500),
    content: Text(
      message,
      style: kPostGetNoteTextStyle,
    ),
  );
}
