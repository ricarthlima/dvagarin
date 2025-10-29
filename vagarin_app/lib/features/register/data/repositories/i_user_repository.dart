import 'package:vagarin_app/shared/models/user_model.dart';
import '../../domain/user_register_data.dart';

abstract class IUserRepository {
  Future<UserModel> registerUser(UserRegisterData data);
}
