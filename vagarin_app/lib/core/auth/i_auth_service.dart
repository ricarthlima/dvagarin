import 'package:vagarin_app/shared/models/auth_user_model.dart';

abstract class IAuthService {
  /// Um Stream que notifica o app sobre mudanças no estado de autenticação.
  /// Emite [AuthUser] no login, [AuthUser.empty] no logout.
  Stream<AuthUser> get onAuthStateChanged;

  AuthUser get currentUser;

  /// Tenta fazer login com email e senha.
  /// Salva o token no [LocalStorageService].
  /// Lança [FirebaseAuthException] em caso de erro.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  /// Tenta criar uma nova conta com email e senha.
  /// Salva o token no [LocalStorageService].
  /// Lança [FirebaseAuthException] em caso de erro.
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Tenta fazer login com o provedor Google.
  /// Salva o token no [LocalStorageService].
  /// Lança [Exception] em caso de erro.
  Future<void> signInWithGoogle();

  /// Desloga o usuário do provedor e limpa o token.
  Future<void> signOut();
}
