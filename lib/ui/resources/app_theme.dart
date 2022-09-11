import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._internal();

  static const Color _lightPrimaryColor = Color(0xE60188C0);
  static const Color _lightPrimaryVariantColor = Color(0xE60188C0);
  static const Color _lightSecondaryColor = Color(0xFF8B8989);
  static const Color _lightBackgroundColor = Color(0xFFE5E5E5);
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _iconColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 20,
      ),
      color: _lightPrimaryVariantColor,
      iconTheme: const IconThemeData(color: _iconColor),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    backgroundColor: _lightBackgroundColor,
    iconTheme: const IconThemeData(color: _iconColor),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
