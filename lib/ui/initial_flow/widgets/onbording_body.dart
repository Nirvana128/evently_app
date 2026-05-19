import 'package:evently/core/extensions/responsive_size_extension.dart';
import 'package:evently/core/extensions/responsive_sized_box_extension.dart';
import 'package:evently/models/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnbordingBody extends StatelessWidget {
  const OnbordingBody({
    super.key,
    required this.controller,
    required this.currentIndex,
  });
  final PageController controller;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final onboarding = Onboarding.getOnboardingPages(context);

    return Expanded(
      child: PageView.builder(
        itemCount: onboarding.length,
        controller: controller,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: .start,
            children: [
              Center(
                child: SvgPicture.asset(
                  onboarding[index].imagePath,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              12.verticalSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboarding.length,
                  (index) => Container(
                    height: 8.square,
                    width: currentIndex == index ? 20.square : 8.square,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: currentIndex == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primaryFixed,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                ),
              ),
              12.verticalSizedBox,
              Text(
                onboarding[index].title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              8.verticalSizedBox,
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    onboarding[index].description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
