import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../globals/database_strings.dart';

class LoginStore {
  static Map<String, dynamic> userData = {};
  static bool isGuest = false;

  bool get isGuestUser {
    return isGuest;
  }

  Future<bool> saveToUserData() async {
    // gets user data stored in local storage
    print("here");
    SharedPreferences instance = await SharedPreferences.getInstance();
    userData = jsonDecode(instance.getString("userInfo")!);
    print(userData);
    print(isGuest);
    if(instance.getBool("isGuest")!){
      isGuest=true;
    }
    return true;
  }

}
