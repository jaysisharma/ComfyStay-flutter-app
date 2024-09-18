import 'package:comfystay/screen/HomeScreen.dart';
import 'package:comfystay/screen/Login.dart';
import 'package:comfystay/screen/Onboarding.dart';
import 'package:comfystay/screen/Profile.dart';
import 'package:comfystay/screen/PropertyListing/Conditions.dart';
import 'package:comfystay/screen/PropertyListing/PropertyType.dart';
import 'package:comfystay/screen/Register.dart';
import 'package:comfystay/screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(20, 133, 115, 1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/profile',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnBoarding()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/property', page: () => const PropertyType()),
        GetPage(name: '/listing', page: () => const PGListing()),
        GetPage(name: '/conditions', page: () =>  ConditionsScreen()),
      ],
    );
  }
}
