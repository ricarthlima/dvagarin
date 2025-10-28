import 'package:flutter/material.dart';
import 'package:vagarin_app/features/auth/pages/login_screen.dart';
import 'package:vagarin_app/features/onboarding/widgets/onboarding_showcase_widget.dart';

class OnboardingLandscapeLayout extends StatelessWidget {
  const OnboardingLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 6, child: OnboardingShowcaseWidget()),
        VerticalDivider(),
        Flexible(flex: 2, child: LoginScreen(isLayout: true)),
      ],
    );
  }
}
