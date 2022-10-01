import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._internal();

  // {
  //     FontWeight.w100: 'Thin',
  //     FontWeight.w200: 'ExtraLight',
  //     FontWeight.w300: 'Light',
  //     FontWeight.w400: 'Regular',
  //     FontWeight.w500: 'Medium',
  //     FontWeight.w600: 'SemiBold',
  //     FontWeight.w700: 'Bold',
  //     FontWeight.w800: 'ExtraBold',
  //     FontWeight.w900: 'Black',
  // }

  static const Color lightPrimaryColor = Color(0xE60188C0);
  static const Color lightSecondaryColor = Color(0xFF8B8989);
  static const Color lightBackgroundColor = Colors.white;
  static const Color errorColor = Color(0xFFFF3333);
  static const Color dividerColor = Color(0xFFE6E8E7);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      error: errorColor,
    ),
    dividerColor: dividerColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 48,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      buttonColor: lightPrimaryColor,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
    iconTheme: const IconThemeData(color: lightPrimaryColor),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    backgroundColor: lightBackgroundColor,
    scaffoldBackgroundColor: lightBackgroundColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: lightBackgroundColor,
    ),
  );
}
