import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor =
      Color(0xFF1E1E8C);

  static ThemeData lightTheme =
      ThemeData(
    useMaterial3: true,

    primaryColor: primaryColor,

    colorScheme:
        ColorScheme.fromSeed(
      seedColor: primaryColor,
    ),

    appBarTheme:
        const AppBarTheme(
      backgroundColor:
          primaryColor,
      foregroundColor:
          Colors.white,
      centerTitle: true,
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
        backgroundColor:
            primaryColor,
        foregroundColor:
            Colors.white,
        minimumSize:
            const Size(
          double.infinity,
          50,
        ),
      ),
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),
    ),
  );
}