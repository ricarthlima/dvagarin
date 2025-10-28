import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/core/theme/app_colors.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/features/auth/stores/signup_form_store.dart';

import '../../../core/helpers/dimensions.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_ui_constants.dart';
import '../../../shared/injection_container.dart';
import '../../../shared/widgets/google_auth_button.dart';
import '../../../shared/widgets/hard_elevated_button.dart';
import '../widgets/email_form_field.dart';
import '../widgets/password_form_field.dart';
import '../widgets/terms_and_privacy_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignUpFormStore formStore = SignUpFormStore();
  final authStore = getIt<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundSecondary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: min(PAGE_CENTER_WIDTH, width(context)),
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 16,
                          children: _buildListWidgets(context),
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).go('/');
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListWidgets(BuildContext context) {
    return [
      Text("Criar conta", style: Theme.of(context).textTheme.headlineLarge),
      SizedBox(),
      Observer(
        builder: (_) => EmailFormField(
          errorText: formStore.emailError,
          onChange: (value) {
            formStore.setEmail(value ?? '');
          },
        ),
      ),
      Observer(
        builder: (_) => PasswordFormField(
          labelText: 'Senha',
          errorText: formStore.passwordError,
          onChange: (value) {
            formStore.setPassword(value ?? '');
          },
        ),
      ),
      Observer(
        builder: (_) => PasswordFormField(
          labelText: 'Confirme a senha',
          errorText: formStore.confirmPasswordError,
          onChange: (value) {
            formStore.setConfirmPassword(value ?? '');
          },
        ),
      ),
      Observer(
        builder: (_) {
          return Text(
            formStore.errorMessage ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.error),
          );
        },
      ),
      Observer(
        builder: (_) {
          if (formStore.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              spacing: 16,
              children: [
                HardElevatedButton(
                  onPressed: () {
                    formStore.submitSignUp();
                  },
                  label: 'Criar conta',
                ),
                Row(
                  spacing: 8,
                  children: [
                    Flexible(child: Divider()),
                    Text("OU", style: Theme.of(context).textTheme.labelMedium),
                    Flexible(child: Divider()),
                  ],
                ),
                HardElevatedButton.grey(
                  onPressed: () {
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRoutes.login, extra: true);
                  },
                  label: "Entrar com minha conta",
                ),
                GoogleAuthButton(
                  onPressed: () {
                    authStore.signInWithGoogle();
                  },
                  themeMode: ThemeMode.light,
                ),
              ],
            );
          }
        },
      ),

      TermsAndPrivacyWidget(),
    ];
  }
}
