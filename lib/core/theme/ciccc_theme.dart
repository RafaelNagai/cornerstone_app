import 'package:flutter/material.dart';

final primaryBlue = Color(0xFF003399);
final lightGray = Color(0xFFF5F5F5);
final grayText = Color(0xFF757575);

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      onPrimary: Colors.white,
      background: lightGray,
      onBackground: grayText,
      surface: Colors.white,
      onSurface: grayText,
    ),
    scaffoldBackgroundColor: lightGray,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      prefixIconColor: primaryBlue,
      labelStyle: TextStyle(color: grayText),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: grayText),
    ),
  );
}
