import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vagarin_app/core/theme/app_colors.dart';
import 'package:vagarin_app/features/register/presentation/widget/register_scaffold_layout.dart';
import 'package:vagarin_app/features/register/presentation/widget/user_image_widget.dart';
import 'package:vagarin_app/shared/helpers/pick_image.dart';

import '../../../../shared/injection_container.dart';
import '../../../../shared/widgets/image_source_selector.dart';
import '../stores/register_store.dart';

class RegisterPhotoLayout extends StatelessWidget {
  const RegisterPhotoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return RegisterScaffoldLayout(
      title: "Mostre-se!",
      subtitle:
          "Será bem mais fácil achar amigos se você tiver uma foto de perfil!",
      child: Observer(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              UserImageWidget(registerStore: registerStore),
              ElevatedButton(
                onPressed: () {
                  _selectPhotoPressed(context, registerStore);
                },
                child: Text("Enviar foto"),
              ),
              if (registerStore.imageFile != null)
                ElevatedButton(
                  onPressed: () {
                    registerStore.cleanPhoto();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.error),
                  ),
                  child: Text("Remover imagem"),
                ),
            ],
          );
        },
      ),
    );
  }

  void _selectPhotoPressed(
    BuildContext context,
    RegisterStore registerStore,
  ) async {
    ImageSource? imageSource = await showModalBottomSheet<ImageSource>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ImageSourceSelector(),
    );

    if (imageSource != null && context.mounted) {
      File? file = await pickImage(context: context, source: imageSource);
      registerStore.setPhoto(imageFile: file);
    }
  }
}
