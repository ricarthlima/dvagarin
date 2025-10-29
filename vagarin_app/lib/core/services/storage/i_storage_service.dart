import 'dart:io';

abstract class IStorageService {
  /// Faz o upload de um arquivo para o caminho especificado.
  /// Retorna a URL pública do arquivo, ou null em caso de falha.
  Future<String?> uploadFile({required File file, required String path});
}
