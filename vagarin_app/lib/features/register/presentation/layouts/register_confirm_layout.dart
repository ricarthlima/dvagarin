import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vagarin_app/features/auth/widgets/terms_and_privacy_widget.dart';
import 'package:vagarin_app/features/register/presentation/widget/register_scaffold_layout.dart';
import 'package:vagarin_app/features/register/presentation/widget/user_image_widget.dart';
import 'package:vagarin_app/shared/widgets/hard_elevated_button.dart';

import '../../../../core/services/geocoding_service.dart';
import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';

class RegisterConfirmLayout extends StatelessWidget {
  const RegisterConfirmLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return RegisterScaffoldLayout(
      title: "Confirme seus dados",
      subtitle: "Estamos quase lá!",
      child: Observer(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                UserImageWidget(registerStore: registerStore, size: 128),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      registerStore.name,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(fontSize: 20),
                    ),
                    Text("@${registerStore.username}"),
                    Text(registerStore.bio),
                  ],
                ),
                Divider(),
                Text(registerStore.phone),
                Text(registerStore.formattedBirthday),
                if (registerStore.hasLocation)
                  FutureBuilder(
                    future: GeocodingService.getAddressFromPosition(
                      registerStore.geoPosition!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data ?? '',
                          textAlign: TextAlign.center,
                        );
                      }
                      return SizedBox();
                    },
                  ),
                SizedBox(height: 16),
                HardElevatedButton(
                  onPressed: () {
                    registerStore.submit();
                  },
                  label: "Registrar-se",
                ),
                TermsAndPrivacyWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
