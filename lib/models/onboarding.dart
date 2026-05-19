import 'package:evently/core/constants/app_images.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Onboarding {
  final String title;
  final String description;
  final String imagePath;

  Onboarding({
    required this.title,
    required this.description,
    required this.imagePath,
  });
  
  static List<Onboarding> getOnboardingPages(BuildContext context) => [
    Onboarding(
      title: AppLocalizations.of(context)!.onboarding2title,
      description:
          AppLocalizations.of(context)!.onboarding2description,
      imagePath: Assets.svgOnboarding1,
    ),
    Onboarding(
      title: AppLocalizations.of(context)!.onboarding3title,
      description:
          AppLocalizations.of(context)!.onboarding3description,
      imagePath: Assets.svgOnboarding2,
    ),
    Onboarding(
      title: AppLocalizations.of(context)!.onboarding4title,
      description: AppLocalizations.of(context)!.onboarding4description,
      imagePath: Assets.svgOnboarding3,
    ),
  ];
}
