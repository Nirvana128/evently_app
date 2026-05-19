import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const AppBarBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      height: 32.square,
      width: 32.square,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: languageProvider.currentLanguage == 'en'
            ? const EdgeInsets.only(left: 10)
            : const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
