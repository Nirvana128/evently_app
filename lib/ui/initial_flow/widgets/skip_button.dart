import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/onboarding.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.controller,
    required this.onboarding,
  });

  final PageController controller;
  final List<Onboarding> onboarding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 6.allPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () {
          controller.animateToPage(
            onboarding.length - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Text(
          AppLocalizations.of(context)!.skip,
          style: Theme.of(context).textTheme.titleMedium!
              .copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
        ),
      ),
    );
  }
}