import 'package:flutter/material.dart';

class DateController extends ChangeNotifier {
  DateTime? dateController;
  DateTime get selectdatetime => dateController ?? DateTime.now();
  void setdate(DateTime value) {
    dateController = value;
    notifyListeners();
  }
}
