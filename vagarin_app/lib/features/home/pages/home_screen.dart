import 'package:flutter/material.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/shared/injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Text(
                  "Boas vindas, ${authStore.currentUser.email}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: () {
                    authStore.signOut();
                  },
                  child: Text("SAIR"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
