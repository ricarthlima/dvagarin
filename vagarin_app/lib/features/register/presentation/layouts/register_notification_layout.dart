import 'package:flutter/material.dart';

import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';

class RegisterNotificationLayout extends StatelessWidget {
  const RegisterNotificationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return Form(child: SingleChildScrollView(child: Column()));
  }
}
