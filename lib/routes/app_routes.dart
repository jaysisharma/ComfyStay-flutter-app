// routes/app_routes.dart
import 'package:comfystay/screen/Onboarding.dart';
import 'package:comfystay/screen/SplashScreen.dart';
import 'package:comfystay/screen/auth/Login.dart';
import 'package:comfystay/screen/auth/Register.dart';
import 'package:comfystay/screen/dashboard/Dashboard.dart';
import 'package:comfystay/screen/dashboard/HomeScreen.dart';
import 'package:comfystay/screen/dashboard/Inbox.dart';
import 'package:comfystay/screen/dashboard/Message_Page.dart';
import 'package:comfystay/screen/dashboard/SearchResult.dart';
import 'package:comfystay/screen/profile/ChangePassword.dart';
import 'package:comfystay/screen/profile/Profile.dart';
import 'package:comfystay/screen/profile/PropertyListing/AddContact.dart';
import 'package:comfystay/screen/profile/PropertyListing/AddPhotos.dart';
import 'package:comfystay/screen/profile/PropertyListing/Conditions.dart';
import 'package:comfystay/screen/profile/PropertyListing/Inital_Requirement.dart';
import 'package:comfystay/screen/profile/PropertyListing/PropertyType.dart';
import 'package:comfystay/screen/profile/PropertyListing/WhatsIncluded.dart';
import 'package:comfystay/screen/profile/PropertyListing/YourListing.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => const OnBoarding()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/search', page: () => SearchScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/property', page: () => const PropertyType()),
    GetPage(name: '/listing', page: () => const ListingPage()),
    GetPage(name: '/conditions', page: () => ConditionsScreen()),
    GetPage(name: '/requirements', page: () => InitialRequirementPage()),
    GetPage(name: '/whatsincluded', page: () => WhatsIncluded()),
    GetPage(name: '/addphotos', page: () => AddPhotosPage()),
    GetPage(name: '/addContact', page: () => AddContact()),
    // GetPage(name: '/propertylisting', page: () => const PropertyListing()),
    GetPage(name: '/inbox', page: () =>  Inbox()),
    GetPage(name: '/change', page: () => const ChangePasswordPage()),
    GetPage(name: '/dashboard', page: () => const Dashboard()),
    // GetPage(
    //   name: '/messagepage',
    //   page: () => MessagePage(), // Passing userId directly
    // ),
    GetPage(name: '/yourlisting', page: () => UserListingsPage()),

    // GetPage(name: '/propertydetail', page: () => const PropertyDetailScreen(resource: null,)),
  ];
}
