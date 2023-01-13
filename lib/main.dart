import 'package:cab_sharing/cab_sharing.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String key = const String.fromEnvironment('SECURITY_KEY');
    return MaterialApp(
      home: CabSharingScreen(userData: {
        'name': 'SWC Tester',
        'email': 'swciitghy@gmail.ac.in',
        'security-key': key
      }),
    );
  }
}
