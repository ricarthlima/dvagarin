import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/firebase_options.dart';
import 'package:vagarin_app/shared/injection_container.dart';

import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: No futuro, podemos separar dev, homolog e prod em projetos
  // Firebase diferentes, mas para essa entrega não é necessário.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupInjections();

  await getIt.allReady();

  await getIt<AuthStore>().checkLoginStatus();

  final router = setupRouter();

  runApp(MainApp(router: router));
}

class MainApp extends StatelessWidget {
  final GoRouter router;
  const MainApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Dvagarin",
      routerConfig: router,
    );
  }
}
