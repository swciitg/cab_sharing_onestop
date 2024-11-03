import 'dart:convert';

import 'package:cab_sharing/cab_sharing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GateLog',
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      'userInfo',
                      jsonEncode({
                        'outlookEmail': 'r.hardik@iitg.ac.in',
                        'name': 'Hardik Roongta',
                        'rollNo': '210102036',
                        'altEmail': 'abc@gmail.com',
                        'phoneNumber': 1234567890,
                        'emergencyPhoneNumber': 0987654321,
                        'gender': 'Male',
                        'roomNo': 'ABCD',
                        'homeAddress': 'homeAddress',
                        'dob': 'dob',
                        'hostel': 'LOHIT',
                        'linkedin': 'linkedin',
                        'image': 'image',
                      }));

                  await prefs.setString("accessToken",
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjRmNzhmM2FhZTg2NDIyNzU0YjE2ZjMiLCJpYXQiOjE3MzA2MjQxOTIsImV4cCI6MTczMTQ4ODE5Mn0.aM4oLvphillfM7_FyCeFgaZiLDwIZTzimhCovaMM3jo");
                  await prefs.setBool('isGuest', false);

                  nav.push(MaterialPageRoute(
                    builder: (context) => const CabSharingSplashScreen(),
                  ));
                },
                child: const Text('Cab Sharing')),
          ),
        );
      }),
    );
  }
}
