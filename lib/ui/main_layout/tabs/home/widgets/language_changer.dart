import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageChanger extends StatelessWidget {
  const LanguageChanger({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: () {
        languageProvider.changeLanguage(
          languageProvider.currentLanguage == 'en' ? 'ar' : 'en',
        );
      },
      child: Container(
        height: 30.square,
        width: 30.square,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            languageProvider.currentLanguage.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
