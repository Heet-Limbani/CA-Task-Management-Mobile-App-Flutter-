import 'package:flutter/material.dart';
import 'package:task_manager/Theme/colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();
  static ThemeData define() {
    return ThemeData(
      primaryColor: colors.lightBlue,
      focusColor: colors.lightBlue,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: colors.darkBlue),
    );
  }
}
