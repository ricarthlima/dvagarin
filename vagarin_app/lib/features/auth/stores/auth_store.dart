import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:vagarin_app/core/auth/i_auth_service.dart';

import '../../../core/router/app_router.dart';
import '../../../shared/models/auth_user_model.dart';

part 'auth_store.g.dart';

enum RegistrationStatus { unknown, required, complete }

class AuthStore extends _AuthStore with _$AuthStore {
  AuthStore(super._authService);
}

abstract class _AuthStore with Store {
  final IAuthService _authService;
  _AuthStore(this._authService) {
    _authService.onAuthStateChanged.listen(_handleAuthStateChange);
  }

  @observable
  bool isAuthenticated = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  AuthUser currentUser = AuthUser.empty;

  @observable
  RegistrationStatus registrationStatus = RegistrationStatus.unknown;

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
      final bool requiresReg = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      isAuthenticated = true;
      registrationStatus = requiresReg
          ? RegistrationStatus.required
          : RegistrationStatus.complete;
    } catch (e) {
      errorMessage = _mapAuthExceptionMessage(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signUpWithEmail(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final bool requiresReg = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );
      isAuthenticated = true;
      registrationStatus = requiresReg
          ? RegistrationStatus.required
          : RegistrationStatus.complete;
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
      final bool requiresReg = await _authService.signInWithGoogle();
      isAuthenticated = true;
      registrationStatus = requiresReg
          ? RegistrationStatus.required
          : RegistrationStatus.complete;
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
      currentUser = AuthUser.empty;
      isAuthenticated = false;
      registrationStatus = RegistrationStatus.unknown;

      final ctx = rootNavigatorKey.currentContext;
      if (ctx != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (rootNavigatorKey.currentContext != null) {
            rootNavigatorKey.currentContext!.go('/');
          }
        });
      }
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
