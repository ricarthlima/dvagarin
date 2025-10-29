// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: _uuidFromString(json['id']),
  firebaseUid: json['firebaseUid'] as String,
  username: json['username'] as String,
  name: json['name'] as String,
  dateOfBirth: _dateTimeFromString(json['dateOfBirth'] as String?),
  bio: json['bio'] as String?,
  profilePictureUrl: json['profilePictureUrl'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  configShowProximity: json['configShowProximity'] as bool,
  configIsPrivate: json['configIsPrivate'] as bool,
  configNotifyReactions: json['configNotifyReactions'] as bool,
  configNotifyFriendPosts: json['configNotifyFriendPosts'] as bool,
  configNotifyPostReminder: json['configNotifyPostReminder'] as bool,
  configNotifyNewFriendRequests: json['configNotifyNewFriendRequests'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': _uuidToString(instance.id),
  'firebaseUid': instance.firebaseUid,
  'username': instance.username,
  'name': instance.name,
  'dateOfBirth': _stringFromDateTime(instance.dateOfBirth),
  'bio': instance.bio,
  'profilePictureUrl': instance.profilePictureUrl,
  'phoneNumber': instance.phoneNumber,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'configShowProximity': instance.configShowProximity,
  'configIsPrivate': instance.configIsPrivate,
  'configNotifyReactions': instance.configNotifyReactions,
  'configNotifyFriendPosts': instance.configNotifyFriendPosts,
  'configNotifyPostReminder': instance.configNotifyPostReminder,
  'configNotifyNewFriendRequests': instance.configNotifyNewFriendRequests,
};
