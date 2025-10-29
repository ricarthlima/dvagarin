import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vagarin_app/features/register/presentation/widget/register_scaffold_layout.dart';

import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';

class RegisterBasicLayout extends StatefulWidget {
  const RegisterBasicLayout({super.key});

  @override
  State<RegisterBasicLayout> createState() => _RegisterBasicLayoutState();
}

class _RegisterBasicLayoutState extends State<RegisterBasicLayout> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    RegisterStore registerStore = getIt<RegisterStore>();

    _nameController.text = registerStore.name;
    _usernameController.text = registerStore.username;
    _dobController.text = registerStore.formattedBirthday;
    _bioController.text = registerStore.bio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return Observer(
      builder: (_) {
        return RegisterScaffoldLayout(
          title: "Informações básicas",
          subtitle: "Vamos começar a se conhecer.",
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      hintText: 'Seu nome e sobrenome',
                      icon: Icon(Icons.person_outline),
                      errorText: registerStore.nameErrorText,
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: registerStore.setName,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      hintText: 'ex: ricarth_lima',
                      icon: Icon(Icons.alternate_email),
                      prefixText: '@',
                      errorText: registerStore.usernameErrorText,
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    enableSuggestions: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9_]')),
                    ],
                    onChanged: registerStore.setUsername,
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      labelText: 'Data de Nascimento',
                      hintText: 'Selecione uma data',
                      icon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _selectDate(context, registerStore);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A data de nascimento é obrigatória';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      hintText: 'Fale um pouco sobre você...',
                      icon: Icon(Icons.edit_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 4,
                    onChanged: registerStore.setBio,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    RegisterStore registerStore,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: registerStore.birthday,
      firstDate: DateTime(1900), // Primeiro ano selecionável
      lastDate: DateTime.now(), // Não pode nascer no futuro
    );

    if (picked != null && picked != registerStore.birthday) {
      registerStore.birthday = picked;
      _bioController.text = registerStore.formattedBirthday;
    }
  }
}
