import 'package:flutter/material.dart';

import 'app_color.dart';

class AppStyle {
  final int themeIndex;

  AppStyle({this.themeIndex = 0});

  ThemeData get currentTheme {
    if (themeIndex >= 0 && themeIndex < AppColor.availableColorSchemes.length) {
      return ThemeData(
        fontFamily: "ElMessiri",
        useMaterial3: true,
        colorScheme: AppColor.availableColorSchemes[themeIndex],
      );
    } else {
      // Return a default theme or any fallback behavior if the index is out of range.
      return ThemeData(
        fontFamily: "ElMessiri",
        useMaterial3: true,
        colorScheme: AppColor.availableColorSchemes[0],
      );
    }
  }
}
