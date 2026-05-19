import 'package:flutter/material.dart';

class FocusUtil {
  FocusUtil._();

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
