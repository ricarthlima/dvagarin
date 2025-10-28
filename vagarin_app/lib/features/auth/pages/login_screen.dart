import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vagarin_app/core/theme/app_colors.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/features/auth/stores/login_form_store.dart';
import 'package:vagarin_app/features/auth/widgets/terms_and_privacy_widget.dart';
import 'package:vagarin_app/shared/injection_container.dart';
import 'package:vagarin_app/shared/widgets/google_auth_button.dart';

import '../../../core/helpers/dimensions.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_ui_constants.dart';
import '../../../shared/widgets/hard_elevated_button.dart';
import '../widgets/email_form_field.dart';
import '../widgets/password_form_field.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatefulWidget {
  final bool isLayout;
  const LoginScreen({super.key, this.isLayout = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  LoginFormStore formStore = LoginFormStore();
  AuthStore authStore = getIt<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: min(PAGE_CENTER_WIDTH, width(context)),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidateMode,
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 16,
                          children: _buildListWidgets(context),
                        ),
                      ),
                    ),
                  ),
                ),
                if (!widget.isLayout)
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
      Text("Entrar", style: Theme.of(context).textTheme.headlineLarge),
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
          onForgetPressed: () {},
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
                    formStore.submitLogin();
                  },
                  label: 'Entrar',
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
                    ).pushNamed(AppRoutes.signup, extra: true);
                  },
                  label: "Criar conta",
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
