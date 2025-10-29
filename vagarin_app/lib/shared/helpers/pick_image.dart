import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:vagarin_app/shared/dialogs/permission_denied_dialog.dart';

final ImagePicker _picker = ImagePicker();

Future<File?> pickImage({
  required BuildContext context,
  required ImageSource source,
}) async {
  PermissionStatus status = PermissionStatus.denied;
  switch (source) {
    case ImageSource.camera:
      status = await Permission.camera.request();
    case ImageSource.gallery:
      status = await Permission.mediaLibrary.request();
  }
  if (!(status.isGranted || status.isLimited || status.isProvisional)) {
    if (!context.mounted) return null;
    showPermissionDeniedDialog(
      context: context,
      permission: source == ImageSource.camera ? "CÂMERA" : "GALERIA",
    );
    return null;
  }
  try {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  } catch (e) {
    print('Erro ao pegar imagem: $e');
    return null;
  }
}
