import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vagarin_app/core/auth/firebase_auth_service.dart';
import 'package:vagarin_app/core/auth/i_auth_service.dart';
import 'package:vagarin_app/core/services/i_secure_local_storage_service.dart';
import 'package:vagarin_app/core/services/secure_storage_service.dart';

import '../core/router/app_router.dart';
import '../features/auth/stores/auth_store.dart';

final getIt = GetIt.instance;

void setupInjections() {
  // Básicos
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Criptografia e token
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<ISecureLocalStorageService>(
    () => SecureStorageService(getIt<FlutterSecureStorage>()),
  );

  // Autenticação de usuário
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
  getIt.registerLazySingleton<IAuthService>(
    () => FirebaseAuthService(
      getIt<FirebaseAuth>(),
      getIt<ISecureLocalStorageService>(),
      getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerSingleton<AuthStore>(AuthStore(getIt<IAuthService>()));
  getIt.registerSingleton<AuthStateListenable>(AuthStateListenable());
}
