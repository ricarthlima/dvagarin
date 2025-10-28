import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vagarin_app/core/services/i_secure_local_service.dart';

class SecureStorageService implements ISecureLocalStorageService {
  final FlutterSecureStorage _storage;

  static const String _authTokenKey = 'auth_token';

  SecureStorageService(this._storage);

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(key: _authTokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _authTokenKey);
  }
}
