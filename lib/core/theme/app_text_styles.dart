import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headlineLarge =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get headlineMedium =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle get headlineSmall =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  
  static TextStyle get labelLarge =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  
  static TextStyle get labelMedium =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get titleLarge =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    
  static TextStyle get titleMedium =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get titleSmall =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  static TextStyle get bodySmall =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
}
