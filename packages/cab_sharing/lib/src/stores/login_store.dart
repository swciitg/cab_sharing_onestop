import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginStore {
  static Map<String, dynamic> userData = {};
  static bool isGuest = false;

  bool get isGuestUser {
    return isGuest;
  }

  static Future<bool> saveToUserData() async {
    // gets user data stored in local storage
    SharedPreferences instance = await SharedPreferences.getInstance();
    userData = jsonDecode(instance.getString("userInfo")!);
    userData["email"] = userData["outlookEmail"];
    if ((instance.getBool("isGuest")!) == true) {
      isGuest = true;
    } else {
      isGuest = false;
    }
    return true;
  }

  static clearAppData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userData.clear();
    isGuest = false;
  }
}
