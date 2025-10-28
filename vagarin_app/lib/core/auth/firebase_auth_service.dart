import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vagarin_app/core/services/i_secure_local_storage_service.dart';
import 'package:vagarin_app/shared/models/auth_user_model.dart';

import 'i_auth_service.dart';

/// Implementação do [AuthService] que usa o Firebase.
class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;
  final ISecureLocalStorageService _localStorageService;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService(
    this._firebaseAuth,
    this._localStorageService,
    this._googleSignIn,
  );

  /// Helper privado para salvar o token do usuário no storage
  Future<void> _saveToken(User? firebaseUser) async {
    if (firebaseUser == null) return;
    try {
      final token = await firebaseUser.getIdToken(true);
      if (token == null) {
        throw Exception('Não foi possível obter o token de autenticação.');
      }
      await _localStorageService.saveToken(token);
    } catch (e) {
      // TODO: Logar o erro (ex: Sentry)
      rethrow;
    }
  }

  /// Helper privado para mapear o User do Firebase para o nosso modelo
  AuthUser _mapFirebaseUserToAuthUser(User? firebaseUser) {
    if (firebaseUser == null) {
      return AuthUser.empty;
    }
    return AuthUser(uid: firebaseUser.uid, email: firebaseUser.email);
  }

  @override
  Stream<AuthUser> get onAuthStateChanged {
    // Mapeia o stream do Firebase para o nosso modelo AuthUser
    return _firebaseAuth.authStateChanges().map(_mapFirebaseUserToAuthUser);
  }

  @override
  AuthUser get currentUser {
    return _mapFirebaseUserToAuthUser(_firebaseAuth.currentUser);
  }

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _saveToken(credential.user);
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // IMPORTANTE: O signUp já loga o usuário, então salvamos o token
    await _saveToken(credential.user);
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope(
          'https://www.googleapis.com/auth/userinfo.profile',
        );
        googleProvider.addScope(
          'https://www.googleapis.com/auth/userinfo.email',
        );
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        await _saveToken(userCredential.user);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        final GoogleSignInAccount googleUser = await googleSignIn
            .authenticate();

        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          // accessToken: googleAuth.,
          idToken: googleAuth.idToken,
        );
        final userCredential = await _firebaseAuth.signInWithCredential(
          credential,
        );
        await _saveToken(userCredential.user);
      }
    } catch (e) {
      // TODO: Logar o erro
      // Tenta deslogar do Google se algo deu errado no meio do caminho
      await _googleSignIn.signOut();
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _localStorageService.deleteToken();
  }
}
