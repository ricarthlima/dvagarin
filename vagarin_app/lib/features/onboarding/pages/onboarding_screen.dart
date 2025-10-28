import 'package:flutter/material.dart';
import 'package:vagarin_app/features/onboarding/layouts/onboarding_landscape_layout.dart';
import 'package:vagarin_app/features/onboarding/layouts/onboarding_portrait_layout.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: OrientationBuilder(
            builder: (context, orientation) {
              switch (orientation) {
                case Orientation.portrait:
                  return OnboardingPortraitLayout();
                case Orientation.landscape:
                  return OnboardingLandscapeLayout();
              }
            },
          ),
        ),
      ),
    );
  }
}
