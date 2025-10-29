import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vagarin_app/features/register/presentation/stores/register_store.dart';
import '../../../../shared/injection_container.dart';
import '../layouts/register_layouts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Observer(
          builder: (_) {
            return Visibility(
              visible: (registerStore.currentPage != RegisterPage.basics),
              child: IconButton(
                onPressed: () {
                  registerStore.backPage();
                },
                icon: Icon(Icons.arrow_back),
              ),
            );
          },
        ),
        actions: [
          Observer(
            builder: (_) {
              return TextButton(
                onPressed: registerStore.canNextPage
                    ? () {
                        registerStore.nextPage();
                      }
                    : null,
                child: Text(registerStore.labelContinueButton),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
          child: Observer(
            builder: (_) {
              if (registerStore.isSubmitting) {
                return Center(child: CircularProgressIndicator());
              }
              return IndexedStack(
                index: registerStore.currentPage.index,
                children: RegisterPage.values.map((e) {
                  switch (e) {
                    case RegisterPage.basics:
                      return RegisterBasicLayout();
                    case RegisterPage.phone:
                      return RegisterPhoneLayout();
                    case RegisterPage.photo:
                      return RegisterPhotoLayout();
                    case RegisterPage.geo:
                      return RegisterGeoLayout();
                    case RegisterPage.confirm:
                      return RegisterConfirmLayout();
                  }
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
