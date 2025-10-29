import 'package:vagarin_app/shared/models/user_model.dart';

abstract class IApiService {
  Future<UserModel?> checkUserRegistration();
  Future<UserModel> registerUser(Map<String, dynamic> userData);
}
