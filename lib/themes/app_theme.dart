import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00E5FF),
      scaffoldBackgroundColor: const Color(0xFF0A0E21),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00E5FF),
        secondary: Color(0xFFFE53BB),
        tertiary: Color(0xFFF2A900),
        surface: Color(0xFF161A36),
      ),
      fontFamily: 'Outfit',
      useMaterial3: true,
    );
  }
}
