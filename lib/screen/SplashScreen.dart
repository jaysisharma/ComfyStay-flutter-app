import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Check if the user is logged in

      if (isLoggedIn) {
        Get.offNamed('/home'); // User is logged in
      } else {
        Get.offNamed('/onboarding'); // User is not logged in
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 27, 27, 1),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
