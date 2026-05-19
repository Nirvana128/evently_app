import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseLanguage extends StatelessWidget {
  final String languageCode;
  const ChooseLanguage({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final bool isSelected = languageProvider.currentLanguage == languageCode;

    return InkWell(
      onTap: () {
        languageProvider.changeLanguage(languageCode);
      },
      child: Container(
        height: 35.height,
        width: 85.width,
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
          child: Text(
            languageCode == 'en' ? 'English' : 'Arabic',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isSelected
                  ? AppColors.white
                  : Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
