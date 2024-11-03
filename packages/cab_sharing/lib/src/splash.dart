import 'package:cab_sharing/src/stores/login_store.dart';
import 'package:flutter/material.dart';

import './screens/home.dart';

class CabSharingSplashScreen extends StatefulWidget {
  const CabSharingSplashScreen({super.key});
  
  @override
  State<CabSharingSplashScreen> createState() => _CabSharingSplashScreenState();
}

class _CabSharingSplashScreenState extends State<CabSharingSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LoginStore.saveToUserData(),
      builder: (buildContext, snapshot) {
        if (snapshot.hasData) {
          return const CabSharingScreen();
        }
        return const Scaffold();
      },
    );
  }
}
