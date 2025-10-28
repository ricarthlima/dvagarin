import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController? passwordController;
  final String labelText;
  final Function? onForgetPressed;
  final Function(String? value)? onChange;
  final String? errorText;

  const PasswordFormField({
    super.key,
    required this.labelText,
    this.passwordController,
    this.onForgetPressed,
    this.onChange,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        labelText: labelText,
        errorText: errorText,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: (onForgetPressed != null)
            ? TextButton(
                onPressed: () {
                  onForgetPressed!();
                },
                child: Text("Esqueceu?"),
              )
            : null,
      ),
      onChanged: onChange,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Insira uma senha";
        }

        if (value.trim().length < 6) {
          return "Uma senha deve ter pelo menos 6 caracteres";
        }

        return null;
      },
    );
  }
}
