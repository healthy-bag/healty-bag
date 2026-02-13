import 'package:flutter/material.dart';
import 'package:healthy_bag/core/theme/app_text_theme.dart';
import 'package:healthy_bag/core/theme/color_schemes.dart';
import 'package:healthy_bag/core/theme/components_theme/button_themes.dart';
import 'package:healthy_bag/core/theme/components_theme/contents_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorSchemes.lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      elevatedButtonTheme: ButtonThemes.elevatedButtonTheme(colorScheme),
      dividerTheme: ContentsTheme.dividerTheme(colorScheme),
      appBarTheme: ContentsTheme.appBarTheme(colorScheme),
      textTheme: AppTextTheme.textTheme(
        ThemeData.light().textTheme,
        colorScheme.onSurface,
      ),
    );
  }
}
