import 'package:flutter/material.dart';

void showPermissionDeniedDialog({
  required BuildContext context,
  required String permission,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Permissão negada"),
        content: Text(
          "A permissão para $permission foi negada. Tente novamente ou consulte as configurações do aparelho.",
        ),
      );
    },
  );
}
