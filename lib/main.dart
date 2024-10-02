// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/utils/theme.dart';  // Import your light/dark theme setup
import 'package:comfystay/routes/app_routes.dart';  // Import your routes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComfyStay',
      theme: lightTheme,        // Light theme configuration
      darkTheme: darkTheme,     // Dark theme configuration
      themeMode: ThemeMode.system,  // Automatically switch based on the system theme
      initialRoute: '/',        // Set the initial route
      getPages: AppRoutes.routes,   // Route definitions
    );
  }
}
