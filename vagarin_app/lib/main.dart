import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vagarin_app/firebase_options.dart';
import 'package:vagarin_app/shared/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: No futuro, podemos separar dev, homolog e prod em projetos
  // Firebase diferentes, mas para essa entrega não é necessário.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupInjections();

  await getIt.allReady();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
