abstract class ISecureLocalStorageService {
  // Para o token do Auth
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}
