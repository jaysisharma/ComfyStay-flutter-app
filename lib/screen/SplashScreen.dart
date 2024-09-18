import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => {Get.toNamed('/onboarding')});
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 27, 27, 1),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
