import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetUtils {
  const WidgetUtils._internal();

  static Widget getFlatButton(
    String text, {
    Color? color,
    VoidCallback? onPressed,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(88, 36),
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.lato(),
      ),
    );
  }

  static Widget getRaisedButton(
    String text, {
    Color? color,
    Color? textColor,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
