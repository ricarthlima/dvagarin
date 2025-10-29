import 'package:flutter/material.dart';

import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';

class RegisterPhoneLayout extends StatelessWidget {
  const RegisterPhoneLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return Form(child: SingleChildScrollView(child: Column()));
  }
}
