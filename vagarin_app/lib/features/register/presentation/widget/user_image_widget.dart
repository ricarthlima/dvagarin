import 'package:flutter/material.dart';
import 'package:vagarin_app/features/register/presentation/stores/register_store.dart';

class UserImageWidget extends StatelessWidget {
  final double size;
  const UserImageWidget({
    super.key,
    required this.registerStore,
    this.size = 256,
  });

  final RegisterStore registerStore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundImage: registerStore.imageFile != null
            ? MemoryImage(registerStore.imageFile!.readAsBytesSync())
            : null,
        backgroundColor: Colors.grey,
        child: registerStore.imageFile == null
            ? Icon(Icons.person, size: 92)
            : null,
      ),
    );
  }
}
