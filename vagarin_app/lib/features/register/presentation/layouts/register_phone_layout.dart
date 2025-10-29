import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vagarin_app/features/register/presentation/widget/register_scaffold_layout.dart';
import 'package:vagarin_app/shared/helpers/b_r_phone_formatter.dart';

import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';

class RegisterPhoneLayout extends StatelessWidget {
  const RegisterPhoneLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return RegisterScaffoldLayout(
      title: "Qual seu número?",
      subtitle: "Essa informação é importante para confirmarmos sua conta.",
      child: Observer(
        builder: (context) {
          return Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  hintText: '(81) 91234-5678',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                  errorText: registerStore.phoneError,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                  BRPhoneFormatter(),
                ],
                onChanged: registerStore.setPhone,
              ),
            ],
          );
        },
      ),
    );
  }
}
