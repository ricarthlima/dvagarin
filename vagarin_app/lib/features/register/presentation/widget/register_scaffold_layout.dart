import 'package:flutter/material.dart';

class RegisterScaffoldLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  const RegisterScaffoldLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 32,
      children: [
        Column(
          spacing: 8,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(subtitle, textAlign: TextAlign.center),
          ],
        ),
        Expanded(child: child),
      ],
    );
  }
}
