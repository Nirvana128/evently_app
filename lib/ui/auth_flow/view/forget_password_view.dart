import 'package:evently/core/constants/app_images.dart';
import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/auth_flow/widgets/custom_button.dart';
import 'package:evently/ui/main_layout/event_features/add_update_event/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitle(title: AppLocalizations.of(context)!.forgetPassword),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          SvgPicture.asset(
            Assets.svgForgetPassword,
            colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!,
              BlendMode.srcIn,
            ),
          ),

          // login button
          20.verticalSizedBox,
          Padding(
            padding: AppPadding.view,
            child: CustomButton(
              onPressed: () {},
              label: AppLocalizations.of(context)!.resetPassword,
            ),
          ),
        ],
      ),
    );
  }
}