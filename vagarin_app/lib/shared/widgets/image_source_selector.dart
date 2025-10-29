import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const double _buttonSize = 100;

class ImageSourceSelector extends StatelessWidget {
  const ImageSourceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Cor de fundo do modal
    const Color modalBackgroundColor = Colors.white;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      decoration: const BoxDecoration(
        color: modalBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          Text(
            "Selecione a origem da foto",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 16,
            children: [
              _SourceButton(
                icon: Icons.camera_alt,
                label: "Câmera",
                source: ImageSource.camera,
                color: Theme.of(context).colorScheme.primary,
              ),
              _SourceButton(
                icon: Icons.photo_library,
                label: "Galeria",
                source: ImageSource.gallery,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          Text(
            "Se for solicitado, libere acesso a câmera e a galeria.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final ImageSource source;
  final Color color;

  const _SourceButton({
    required this.icon,
    required this.label,
    required this.source,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(source);
      },
      borderRadius: BorderRadius.circular(_buttonSize / 2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: _buttonSize,
              height: _buttonSize,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5), width: 1.5),
              ),
              child: Icon(icon, size: 48, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
