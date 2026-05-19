import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTheme extends StatelessWidget {
  final ThemeMode themeCode;
  const ChooseTheme({super.key, required this.themeCode});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isSelected = themeProvider.currentMode == themeCode;

    return InkWell(
      onTap: () {
        themeProvider.toggleTheme(themeCode);
      },
      child: Container(
        height: 35.height,
        width: 50.width,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            themeCode == ThemeMode.light
                ? isSelected ? Icons.light_mode : Icons.light_mode_outlined
                : isSelected ? Icons.dark_mode : Icons.dark_mode_outlined,
            color: isSelected
                ? AppColors.white
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
