import 'package:flutter/material.dart';

class ContentsTheme {
  static DividerThemeData dividerTheme(ColorScheme colors) {
    return DividerThemeData(
      color: colors.onSurface,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  static AppBarThemeData appBarTheme(ColorScheme colors) {
    return AppBarThemeData(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      elevation: 0,
    );
  }
}
