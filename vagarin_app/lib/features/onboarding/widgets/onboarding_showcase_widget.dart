import 'package:flutter/material.dart';
import 'package:vagarin_app/features/onboarding/widgets/layouts/onboarding_showcase_landscape_layout.dart';
import 'package:vagarin_app/features/onboarding/widgets/layouts/onboarding_showcase_portrait_layout.dart';

class OnboardingShowcaseWidget extends StatelessWidget {
  const OnboardingShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        switch (orientation) {
          case Orientation.portrait:
            return OnboardingShowcasePortraitLayout();
          case Orientation.landscape:
            return OnboardingShowcaseLandscapeLayout();
        }
      },
    );
  }
}
