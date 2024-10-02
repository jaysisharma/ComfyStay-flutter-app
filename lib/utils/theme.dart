import 'package:flutter/material.dart';

final ThemeData baseTheme = ThemeData(
  primaryColor: const Color(0xFF148573),
  useMaterial3: true,
  textTheme: const TextTheme(
    headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 16.0),
  ),
  // Common properties for both light and dark themes
);

final ThemeData lightTheme = baseTheme.copyWith(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF148573),
    secondary: Colors.deepPurple,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF148573),
  ),
);

final ThemeData darkTheme = baseTheme.copyWith(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF148573),
    secondary: Colors.deepPurple,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
);
