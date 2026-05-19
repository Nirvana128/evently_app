import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/responsive/responsive_config.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:evently/ui/initial_flow/widgets/choose_language.dart';
import 'package:evently/ui/initial_flow/widgets/choose_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SetupView extends StatelessWidget {
  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveConfig.init(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.view,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Image.asset(
                  themeProvider.currentMode == ThemeMode.dark
                      ? Assets.imagesEventlyIconDark
                      : Assets.imagesEventlyIcon,
                ),
                24.verticalSizedBox,
                SvgPicture.asset(
                  Assets.svgBeingCreative2,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
                24.verticalSizedBox,
                Text(
                  AppLocalizations.of(context)!.onboarding1title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                8.verticalSizedBox,
                Text(
                  AppLocalizations.of(context)!.onboarding1description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                16.verticalSizedBox,
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Spacer(),
                    ChooseLanguage(languageCode: 'en'),
                    10.horizontalSizedBox,
                    ChooseLanguage(languageCode: 'ar'),
                  ],
                ),
                16.verticalSizedBox,
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Spacer(),
                    ChooseTheme(themeCode: ThemeMode.light),
                    10.horizontalSizedBox,
                    ChooseTheme(themeCode: ThemeMode.dark),
                  ],
                ),
                24.verticalSizedBox,
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.onboardingsView,
                    );
                  },
                  label: AppLocalizations.of(context)!.letsStart,
                ),
                12.verticalSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
