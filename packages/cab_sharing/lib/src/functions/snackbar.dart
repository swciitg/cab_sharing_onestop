import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

SnackBar getSnackBar(String message, {bool isError = false}) {
  return SnackBar(
    content: Row(
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.check_circle_outline,
          color: OColor.white,
          size: 20,
        ),
        const SizedBox(width: OSpacing.s),
        Expanded(
          child: Text(
            message,
            style: OTextStyle.labelLarge.copyWith(color: OColor.white),
          ),
        ),
      ],
    ),
    backgroundColor: isError ? OColor.red600 : OColor.green600,
    behavior: SnackBarBehavior.floating,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: OSpacing.m, vertical: OSpacing.m),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
  );
}
