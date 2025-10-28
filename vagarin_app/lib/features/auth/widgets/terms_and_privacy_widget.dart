import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/core/router/app_routes.dart';

class TermsAndPrivacyWidget extends StatelessWidget {
  const TermsAndPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Ao entrar no DVagarin, você concorda com nossos ",
        style: Theme.of(context).textTheme.labelMedium,
        children: [
          TextSpan(
            text: "Termos",
            style: TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).goNamed(AppRoutes.legalTerms);
              },
          ),
          TextSpan(text: " e "),
          TextSpan(
            text: "Política de Privacidade",
            style: TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).goNamed(AppRoutes.legalPrivacy);
              },
          ),
          TextSpan(text: "."),
        ],
      ),
    );
  }
}
