import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:vagarin_app/shared/models/user_model.dart';

void main() {
  group('UserModel', () {
    // Um UUID válido para teste
    final testUuid = const Uuid().v4();
    // Data de nascimento para teste
    final testDate = DateTime.parse("1990-10-15T00:00:00.000");

    // JSON de exemplo vindo da API (baseado no UserProfileResponseDTO do backend)
    final Map<String, dynamic> jsonMap = {
      "id": testUuid, // Agora é UUID
      "firebaseUid": "FIREBASE_UID_123",
      "username": "ricarth_lima",
      "name": "Ricarth Lima",
      "dateOfBirth": "1990-10-15", // API manda como String
      "bio": "Flutter dev",
      "profilePictureUrl": "http://example.com/pic.jpg",
      "phoneNumber": "123456789",
      "latitude": -8.0578, // API manda double
      "longitude": -34.8813, // API manda double
      "configShowProximity": true,
      "configIsPrivate": false,
      "configNotifyReactions": true,
      "configNotifyFriendPosts": true,
      "configNotifyPostReminder": false,
      "configNotifyNewFriendRequests": true,
    };

    // Objeto Dart esperado após o parsing
    final expectedUserModel = UserModel(
      id: testUuid,
      firebaseUid: "FIREBASE_UID_123",
      username: "ricarth_lima",
      name: "Ricarth Lima",
      dateOfBirth: testDate, // Esperamos que seja convertido para DateTime
      bio: "Flutter dev",
      profilePictureUrl: "http://example.com/pic.jpg",
      phoneNumber: "123456789",
      latitude: -8.0578,
      longitude: -34.8813,
      configShowProximity: true,
      configIsPrivate: false,
      configNotifyReactions: true,
      configNotifyFriendPosts: true,
      configNotifyPostReminder: false,
      configNotifyNewFriendRequests: true,
    );

    test('deve criar uma instância de UserModel a partir de um JSON', () {
      // Act
      final userModel = UserModel.fromJson(jsonMap);

      // Assert
      expect(userModel, equals(expectedUserModel));
      // Checa especificamente a conversão da data
      expect(userModel.dateOfBirth, isA<DateTime>());
      expect(userModel.dateOfBirth, equals(testDate));
    });

    test('deve converter uma instância de UserModel para JSON', () {
      // Act
      final resultJson = expectedUserModel.toJson();

      // Assert
      // Precisamos ajustar o dateOfBirth de volta para String no formato YYYY-MM-DD
      final expectedJson = Map<String, dynamic>.from(jsonMap); // Cria cópia
      expectedJson['dateOfBirth'] = '1990-10-15'; // Ajusta formato da data

      expect(resultJson, equals(expectedJson));
    });

    test('deve tratar campos opcionais/nulos corretamente no fromJson', () {
      final jsonMapNullable = {
        "id": testUuid,
        "firebaseUid": "FIREBASE_UID_456",
        "username": "outro_user",
        "name": "Outro User",
        // dateOfBirth, bio, profilePictureUrl, phoneNumber, latitude, longitude são nulos
        "configShowProximity": false,
        "configIsPrivate": true,
        "configNotifyReactions": false,
        "configNotifyFriendPosts": false,
        "configNotifyPostReminder": true,
        "configNotifyNewFriendRequests": false,
      };

      final expectedModelNullable = UserModel(
        id: testUuid,
        firebaseUid: "FIREBASE_UID_456",
        username: "outro_user",
        name: "Outro User",
        // Campos opcionais devem ser nulos
        dateOfBirth: null,
        bio: null,
        profilePictureUrl: null,
        phoneNumber: null,
        latitude: null,
        longitude: null,
        // Bools não podem ser nulos (a API sempre os envia)
        configShowProximity: false,
        configIsPrivate: true,
        configNotifyReactions: false,
        configNotifyFriendPosts: false,
        configNotifyPostReminder: true,
        configNotifyNewFriendRequests: false,
      );

      // Act
      final userModel = UserModel.fromJson(jsonMapNullable);

      // Assert
      expect(userModel, equals(expectedModelNullable));
    });
  });
}
