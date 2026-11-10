// lib/core/theme.dart
import 'package:flutter/material.dart';

class AnteCareTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: const Color(0xFF1F1F1F),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
  );
}