// routes/app_routes.dart
import 'package:comfystay/screen/Onboarding.dart';
import 'package:comfystay/screen/SplashScreen.dart';
import 'package:comfystay/screen/auth/Login.dart';
import 'package:comfystay/screen/auth/Register.dart';
import 'package:comfystay/screen/dashboard/Dashboard.dart';
import 'package:comfystay/screen/dashboard/HomeScreen.dart';
import 'package:comfystay/screen/dashboard/Inbox.dart';
import 'package:comfystay/screen/dashboard/Message_Page.dart';
import 'package:comfystay/screen/dashboard/PropertyDetail.dart';
import 'package:comfystay/screen/profile/Profile.dart';
import 'package:comfystay/screen/profile/PropertyListing/AddContact.dart';
import 'package:comfystay/screen/profile/PropertyListing/AddPhotos.dart';
import 'package:comfystay/screen/profile/PropertyListing/Conditions.dart';
import 'package:comfystay/screen/profile/PropertyListing/Inital_Requirement.dart';
import 'package:comfystay/screen/profile/PropertyListing/PropertyListing.dart';
import 'package:comfystay/screen/profile/PropertyListing/PropertyType.dart';
import 'package:comfystay/screen/profile/PropertyListing/WhatsIncluded.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
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
    GetPage(name: '/messagepage', page: () => const MessagePage()),
    GetPage(name: '/propertydetail', page: () => const PropertyDetailScreen()),
  ];
}
