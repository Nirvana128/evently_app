import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/onboarding.dart';
import 'package:evently/services/prefs_service.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.currentIndex,
    required this.controller,
  });

  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final onboarding = Onboarding.getOnboardingPages(context);

    return CustomButton(
      onPressed: () async {
        if (currentIndex < onboarding.length - 1) {
          controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          await PrefsService.setIntroSeen();
          Navigator.pushReplacementNamed(context, AppRoutes.registerView);
        }
      },
      label: currentIndex < onboarding.length - 1
          ? AppLocalizations.of(context)!.next
          : AppLocalizations.of(context)!.getStarted,
    );
  }
}
