import 'package:comfystay/controllers/DataController.dart';
import 'package:comfystay/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/utils/theme.dart'; // Import your light/dark theme setup
import 'package:comfystay/routes/app_routes.dart'; // Import your routes
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Firebase App Check
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  Get.put(DataController());

  Get.put(FavoriteController()); // Initialize the controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComfyStay',
      theme: lightTheme, // Light theme configuration
      darkTheme: darkTheme, // Dark theme configuration
      themeMode:
          ThemeMode.light, // Automatically switch based on the system theme
      initialRoute: '/', // Set the initial route
      getPages: AppRoutes.routes, // Route definitions
      // home: PropertyList(),
    );
  }
}
