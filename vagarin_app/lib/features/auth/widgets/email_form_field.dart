import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isEnabled;
  final Function(String? value)? onChange;
  final String? errorText;

  const EmailFormField({
    super.key,
    this.controller,
    this.isEnabled,
    this.onChange,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      decoration: InputDecoration(
        label: Text("E-mail"),
        hintText: 'exemplo@dominio.com',
        prefixIcon: Icon(Icons.email),
        errorText: errorText,
      ),
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.email],
      onChanged: onChange,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe seu e-mail';
        }
        // Regex simples para formato de email
        const pattern = r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$';
        final regex = RegExp(pattern);
        if (!regex.hasMatch(value)) {
          return 'E-mail inválido';
        }
        return null;
      },
    );
  }
}
