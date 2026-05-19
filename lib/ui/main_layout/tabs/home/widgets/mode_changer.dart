import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeChanger extends StatelessWidget {
  const ModeChanger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme(
          themeProvider.currentMode == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
        );
      },
      icon: themeProvider.currentMode == ThemeMode.light
          ? Icon(Icons.light_mode_outlined)
          : Icon(Icons.dark_mode_outlined),
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
