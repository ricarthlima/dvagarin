import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/core/router/app_routes.dart';
import 'package:vagarin_app/features/onboarding/widgets/onboarding_showcase_widget.dart';

import '../../../shared/widgets/hard_elevated_button.dart';

class OnboardingPortraitLayout extends StatelessWidget {
  const OnboardingPortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          OnboardingShowcaseWidget(),
          SizedBox(height: 16),
          HardElevatedButton(
            onPressed: () {
              GoRouter.of(context).pushNamed(AppRoutes.signup);
            },
            label: "Comece agora",
          ),
          Row(
            spacing: 8,
            children: [
              Flexible(child: Divider()),
              Text("OU", style: Theme.of(context).textTheme.labelMedium),
              Flexible(child: Divider()),
            ],
          ),
          HardElevatedButton.grey(
            onPressed: () {
              GoRouter.of(context).pushNamed(AppRoutes.login);
            },
            label: "Já tenho uma conta",
          ),
        ],
      ),
    );
  }
}
