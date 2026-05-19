import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/models/onboarding.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/initial_flow/widgets/app_bar_back_button.dart';
import 'package:evently/ui/initial_flow/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({
    super.key,
    required this.currentIndex,
    required this.controller,
  });

  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final onboarding = Onboarding.getOnboardingPages(context);

    return SizedBox(
      height: 50.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            themeProvider.currentMode == ThemeMode.dark
                ? Assets.imagesEventlyIconDark
                : Assets.imagesEventlyIcon,
            height: 28.height,
          ),

          currentIndex > 0
              ? Positioned(
                  left: languageProvider.currentLanguage == 'en' ? 0 : null,
                  right: languageProvider.currentLanguage == 'en' ? null : 0,
                  child: AppBarBackButton(
                    onTap: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                )
              : Container(),

          currentIndex < onboarding.length - 1
              ? Positioned(
                  right: languageProvider.currentLanguage == 'en' ? 0 : null,
                  left: languageProvider.currentLanguage == 'en' ? null : 0,
                  child: SkipButton(
                    controller: controller,
                    onboarding: onboarding,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
