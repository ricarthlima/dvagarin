import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:vagarin_app/shared/injection_container.dart';

import 'i_storage_service.dart';

/// Implementação do [IStorageService] usando Firebase Storage.
class FirebaseStorageService implements IStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = getIt<Logger>();

  @override
  Future<String?> uploadFile({required File file, required String path}) async {
    try {
      final storageRef = _storage.ref().child(path);

      _logger.d('[StorageService] Iniciando upload para: $path');

      // Faz o upload
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});

      // Obtém a URL pública
      final downloadUrl = await snapshot.ref.getDownloadURL();

      _logger.i('[StorageService] Upload concluído. URL: $downloadUrl');
      return downloadUrl;
    } catch (e, s) {
      _logger.e(
        '[StorageService] Falha no upload de arquivo',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }
}
