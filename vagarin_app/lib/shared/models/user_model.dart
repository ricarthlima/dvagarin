import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart'; // Para o tipo UuidValue

part 'user_model.g.dart'; // Arquivo gerado

@JsonSerializable()
class UserModel extends Equatable {
  // Use UuidValue se estiver usando o pacote uuid, ou String se a API retornar string
  @JsonKey(
    name: 'id',
    fromJson: _uuidFromString,
    toJson: _uuidToString,
  ) // Conversor customizado
  final String id; // Mantido como String para simplicidade com json_serializable
  // Poderia ser UuidValue se preferir mais tipagem forte.

  final String firebaseUid;
  final String username;
  final String name;

  @JsonKey(fromJson: _dateTimeFromString, toJson: _stringFromDateTime)
  final DateTime? dateOfBirth;

  final String? bio;
  final String? profilePictureUrl;
  final String? phoneNumber;
  final double? latitude;
  final double? longitude;

  // Bools (não podem ser nulos no JSON da API)
  final bool configShowProximity;
  final bool configIsPrivate;
  final bool configNotifyReactions;
  final bool configNotifyFriendPosts;
  final bool configNotifyPostReminder;
  final bool configNotifyNewFriendRequests;

  const UserModel({
    required this.id,
    required this.firebaseUid,
    required this.username,
    required this.name,
    this.dateOfBirth,
    this.bio,
    this.profilePictureUrl,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    required this.configShowProximity,
    required this.configIsPrivate,
    required this.configNotifyReactions,
    required this.configNotifyFriendPosts,
    required this.configNotifyPostReminder,
    required this.configNotifyNewFriendRequests,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    firebaseUid,
    username,
    name,
    dateOfBirth,
    bio,
    profilePictureUrl,
    phoneNumber,
    latitude,
    longitude,
    configShowProximity,
    configIsPrivate,
    configNotifyReactions,
    configNotifyFriendPosts,
    configNotifyPostReminder,
    configNotifyNewFriendRequests,
  ];
}

String _uuidToString(String uuidValue) => uuidValue;

String _uuidFromString(dynamic uuid) {
  if (uuid is String) {
    // Valida se é um UUID válido (opcional mas bom)
    try {
      Uuid.parse(uuid);
      return uuid;
    } catch (_) {
      throw FormatException('UUID inválido recebido da API: $uuid');
    }
  }
  throw FormatException('Formato de UUID inesperado recebido da API: $uuid');
}

// Helper para converter String YYYY-MM-DD para DateTime e vice-versa
// (Opcional, mas útil para json_serializable)
DateTime? _dateTimeFromString(String? dateString) {
  if (dateString == null) return null;
  // Adiciona T00:00:00 para garantir que o parse funcione consistentemente
  return DateTime.tryParse("${dateString}T00:00:00.000");
}

String? _stringFromDateTime(DateTime? dateTime) {
  if (dateTime == null) return null;
  // Formata para YYYY-MM-DD
  return "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
