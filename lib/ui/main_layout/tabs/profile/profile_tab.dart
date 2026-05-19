import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_routes.dart';
import 'package:evently/core/extensions/responsive_padding_extension.dart';
import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/utils/toast_utils.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/main_layout/tabs/home/widgets/language_changer.dart';
import 'package:evently/ui/main_layout/tabs/profile/widgets/custom_show_dialog.dart';
import 'package:evently/ui/main_layout/tabs/profile/widgets/setting_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        // Profile Picture
        Container(
          height: 116.square,
          width: 116.square,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Assets.imagesRoute),
              fit: BoxFit.contain,
            ),
          ),
        ),
        16.verticalSizedBox,

        // Name
        Text(
          userProvider.currentUser?.name ?? "No Name",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        4.verticalSizedBox,

        // Email
        Text(
          FirebaseAuth.instance.currentUser?.email ?? "No Email",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        32.verticalSizedBox,

        // Dark Mode Toggle
        SettingWidget(
          title: AppLocalizations.of(context)!.darkMode,
          trailing: Transform.scale(
            scale: .7,
            child: Switch(
              value: themeProvider.currentMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),
        ),
        16.verticalSizedBox,

        // Language Selection
        SettingWidget(
          title: AppLocalizations.of(context)!.language,
          trailing: Padding(
            padding: 10.horizontalPadding,
            child: LanguageChanger(),
          ),
        ),
        16.verticalSizedBox,

        // Logout
        SettingWidget(
          title: AppLocalizations.of(context)!.logout,
          trailing: CustomShowDialog(
            title: AppLocalizations.of(context)!.confirmLogout,
            contentText: AppLocalizations.of(
              context,
            )!.areYouSureYouWantToLogout,
            onConfirm: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.loginView, (route) => false);

              ToastUtils.showSuccessToast(
                AppLocalizations.of(context)!.loggedOutSuccessfully,
                context,
              );
            },
          ),
        ),
      ],
    );
  }
}