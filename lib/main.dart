import 'package:comfystay/screen/Dashboard.dart';
import 'package:comfystay/screen/HomeScreen.dart';
import 'package:comfystay/screen/Inbox.dart';
import 'package:comfystay/screen/Login.dart';
import 'package:comfystay/screen/Onboarding.dart';
import 'package:comfystay/screen/Profile.dart';
import 'package:comfystay/screen/PropertyListing/AddContact.dart';
import 'package:comfystay/screen/PropertyListing/AddPhotos.dart';
import 'package:comfystay/screen/PropertyListing/Conditions.dart';
import 'package:comfystay/screen/PropertyListing/Inital_Requirement.dart';
import 'package:comfystay/screen/PropertyListing/PropertyListing.dart';
import 'package:comfystay/screen/PropertyListing/PropertyType.dart';
import 'package:comfystay/screen/PropertyListing/WhatsIncluded.dart';
import 'package:comfystay/screen/Register.dart';
import 'package:comfystay/screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Initialize controllers or dependencies globally here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComfyStay',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(20, 133, 115, 1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/dashboard',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnBoarding()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/property', page: () => const PropertyType()),
        GetPage(name: '/listing', page: () => const PGListing()),
        GetPage(name: '/conditions', page: () => ConditionsScreen()),
        GetPage(name: '/requirements', page: () => InitialRequirement()),
        GetPage(name: '/whatsincluded', page: () => WharsIncluded()),
        GetPage(name: '/addphotos', page: () => AddPhotosPage()),
        GetPage(name: '/addContact', page: () => const AddContact()),
        GetPage(name: '/propertylisting', page: () => const PropertyListing()),
        GetPage(name: '/inbox', page: () => const Inbox()),
        GetPage(name: '/dashboard', page: () => const Dashboard()),
      ],
    );
  }
}
