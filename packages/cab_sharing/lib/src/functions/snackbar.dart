import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

SnackBar getSnackBar(
  String message, {
  bool isError = false,
  bool isWarning = false,
}) {
  final Color bgColor = isError
      ? OColor.red600
      : isWarning
          ? OColor.yellow500
          : OColor.green600;
  final IconData icon = isError
      ? Icons.error_outline
      : isWarning
          ? Icons.warning_amber_rounded
          : Icons.check_circle_outline;

  return SnackBar(
    content: Row(
      children: [
        Icon(icon, color: OColor.white, size: 20),
        const SizedBox(width: OSpacing.s),
        Expanded(
          child: Text(
            message,
            style: OTextStyle.labelLarge.copyWith(color: OColor.white),
          ),
        ),
      ],
    ),
    backgroundColor: bgColor,
    behavior: SnackBarBehavior.floating,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: OSpacing.m, vertical: OSpacing.m),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
  );
}
