import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagarin_app/core/services/i_secure_local_storage_service.dart';
import 'package:vagarin_app/core/services/secure_storage_service.dart';

// 1. Mock da nova dependência
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late ISecureLocalStorageService service;
  late MockFlutterSecureStorage mockStorage;

  const String authTokenKey = 'auth_token';

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureStorageService(mockStorage);
  });

  group('SecureStorageService', () {
    const testToken = 'fake-jwt-token-12345';

    test('deve salvar o token no SecureStorage', () async {
      when(
        () => mockStorage.write(key: authTokenKey, value: testToken),
      ).thenAnswer((_) async {});

      await service.saveToken(testToken);

      verify(
        () => mockStorage.write(key: authTokenKey, value: testToken),
      ).called(1);
    });

    test('deve ler o token do SecureStorage', () async {
      when(
        () => mockStorage.read(key: authTokenKey),
      ).thenAnswer((_) async => testToken);

      final token = await service.getToken();

      expect(token, testToken);
      verify(() => mockStorage.read(key: authTokenKey)).called(1);
    });

    test('deve retornar null se o token não existir', () async {
      when(
        () => mockStorage.read(key: authTokenKey),
      ).thenAnswer((_) async => null);

      final token = await service.getToken();

      expect(token, isNull);
    });

    test('deve deletar o token do SecureStorage', () async {
      when(
        () => mockStorage.delete(key: authTokenKey),
      ).thenAnswer((_) async {});

      await service.deleteToken();

      verify(() => mockStorage.delete(key: authTokenKey)).called(1);
    });
  });
}
