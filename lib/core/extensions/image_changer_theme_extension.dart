import 'package:flutter/material.dart';

extension ImageChanger on String {
  String changeImageTheme(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return replaceAll('light', 'dark');
    } else {
      return replaceAll('dark', 'light');
    }
  }
}