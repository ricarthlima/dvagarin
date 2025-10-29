import 'package:vagarin_app/core/api/i_api_service.dart';
import 'package:vagarin_app/shared/models/user_model.dart';

import '../../../../core/services/storage/i_storage_service.dart';
import '../../domain/user_register_data.dart';
import 'i_user_repository.dart';

class UserRepository implements IUserRepository {
  final IApiService _apiService;
  final IStorageService _storageService;

  static const String _profilePicturesPath = 'profile_pictures';

  UserRepository(this._apiService, this._storageService);

  @override
  Future<UserModel> registerUser(UserRegisterData data) async {
    String? profilePictureUrl;

    if (data.imageFile != null) {
      final String uploadPath =
          '$_profilePicturesPath/${data.firebaseUid}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      profilePictureUrl = await _storageService.uploadFile(
        file: data.imageFile!,
        path: uploadPath,
      );
    }

    final Map<String, dynamic> registerJson = {
      // Campos obrigatórios:
      'firebaseUid': data.firebaseUid,
      'username': data.username,
      'name': data.name,
      'dateOfBirth': data.birthday.toString().split(' ')[0],

      // Campos basicos:
      'bio': data.bio,
      'phoneNumber': data.phone,
      'profilePictureUrl': profilePictureUrl,

      // Campos de geo:
      'latitude': data.geoPosition?.latitude,
      'longitude': data.geoPosition?.longitude,

      // notificacao e privacidade pro futuro
      'configShowProximity': data.geoPosition != null,
      'configIsPrivate': false,
      'configNotifyReactions': data.hasActiveNotifications,
      'configNotifyFriendPosts': data.hasActiveNotifications,
      'configNotifyPostReminder': data.hasActiveNotifications,
      'configNotifyNewFriendRequests': data.hasActiveNotifications,
    };

    final UserModel newUser = await _apiService.registerUser(registerJson);

    return newUser;
  }
}
