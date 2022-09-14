import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._internal();

  static const Color _lightPrimaryColor = Color(0xE60188C0);
  static const Color _lightSecondaryColor = Color(0xFF8B8989);
  static const Color _lightBackgroundColor = Colors.white;
  static const Color _errorColor = Color(0xFFFF3333);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      error: _errorColor,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 48,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      buttonColor: _lightPrimaryColor,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
    iconTheme: const IconThemeData(color: _lightPrimaryColor),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    backgroundColor: _lightBackgroundColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
  );
}
