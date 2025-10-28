import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:vagarin_app/core/auth/i_auth_service.dart';

import '../../../shared/models/auth_user_model.dart';

part 'auth_store.g.dart';

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(super._authService);
}

abstract class _AuthStore with Store {
  final IAuthService _authService;
  _AuthStore(this._authService);

  @observable
  bool isAuthenticated = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  AuthUser currentUser = AuthUser.empty;

  @computed
  bool get isLoggedOut => !isAuthenticated && !isLoading;

  @action
  Future<void> checkLoginStatus() async {
    isLoading = true;

    currentUser = _authService.currentUser;
    isAuthenticated = currentUser.isNotEmpty;

    isLoading = false;

    _authService.onAuthStateChanged.listen(_handleAuthStateChange);
  }

  @action
  void _handleAuthStateChange(AuthUser authUser) {
    currentUser = authUser;
    isAuthenticated = authUser.isNotEmpty;
  }

  @action
  Future<void> signInWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.signInWithEmail(email: email, password: password);
    } catch (e) {
      errorMessage = _mapAuthExceptionMessage(
        e,
      ); // Mapeia o erro para algo legível
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUpWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.signUpWithEmail(email: email, password: password);
    } catch (e) {
      errorMessage = _mapAuthExceptionMessage(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signInWithGoogle() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      errorMessage = _mapAuthExceptionMessage(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    errorMessage = null;
    try {
      await _authService.signOut();
    } catch (e) {
      errorMessage = "Erro ao fazer logout: ${e.toString()}";
    } finally {
      isLoading = false;
    }
  }

  String _mapAuthExceptionMessage(Object exception) {
    if (exception is FirebaseAuthException) {
      switch (exception.code) {
        case 'user-not-found':
        case 'wrong-password':
          return 'E-mail ou senha inválidos.';
        case 'email-already-in-use':
          return 'Este e-mail já está cadastrado.';
        case 'weak-password':
          return 'Senha muito fraca.';
        default:
          return 'Erro de autenticação: ${exception.message}';
      }
    }
    return 'Ocorreu um erro inesperado: ${exception.toString()}';
  }
}
