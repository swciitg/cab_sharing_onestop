import 'package:cab_sharing/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void showSnackBar(String message) {
  cabSharingRootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void showErrorSnackBar(DioException err) {
  cabSharingRootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(
      (err.response != null)
          ? err.response!.data['message']
          : "Some error occurred. try again"
    ),
    duration: const Duration(seconds: 5),
  ));
}
