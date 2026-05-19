import 'package:evently/core/constants/app_padding.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/core/responsive/responsive_config.dart';
import 'package:evently/ui/initial_flow/widgets/onboarding_app_bar.dart';
import 'package:evently/ui/initial_flow/widgets/onboarding_button.dart';
import 'package:evently/ui/initial_flow/widgets/onbording_body.dart';
import 'package:flutter/material.dart';

class OnboardingsView extends StatefulWidget {
  const OnboardingsView({super.key});

  @override
  State<OnboardingsView> createState() => _OnboardingsViewState();
}

class _OnboardingsViewState extends State<OnboardingsView> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int newIndex = controller.page!.toInt();
      if (newIndex != currentIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: OnboardingAppBar(
          currentIndex: currentIndex,
          controller: controller,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.view,
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              16.verticalSizedBox,
              OnbordingBody(controller: controller, currentIndex: currentIndex),
              16.verticalSizedBox,
              OnboardingButton(
                currentIndex: currentIndex,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}