import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';

import '../../../shared/injection_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("REGISTER"),
            ElevatedButton(
              onPressed: () {
                getIt<AuthStore>().signOut();
                if (context.mounted) context.go('/');
              },
              child: Text("SAIR"),
            ),
          ],
        ),
      ),
    );
  }
}
