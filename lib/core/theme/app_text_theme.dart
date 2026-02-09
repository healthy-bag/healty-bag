import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme textTheme(TextTheme base, Color color) {
    return base.copyWith(
      titleLarge: TextStyle(
        fontFamily: 'SF Pro',
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(fontFamily: 'SF Pro', color: color, fontSize: 16),
      bodySmall: TextStyle(fontFamily: 'SF Pro', color: color, fontSize: 14),
    );
  }
}
