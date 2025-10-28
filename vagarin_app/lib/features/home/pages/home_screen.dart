import 'package:flutter/material.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/shared/injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              getIt<AuthStore>().signOut();
            },
            child: Text("SAIR"),
          ),
        ),
      ),
    );
  }
}
