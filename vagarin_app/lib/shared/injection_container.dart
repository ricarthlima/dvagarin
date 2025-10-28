import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vagarin_app/core/services/i_secure_local_service.dart';
import 'package:vagarin_app/core/services/secure_storage_service.dart';

final getIt = GetIt.instance;

void setupInjections() {
  // Básicos
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Criptografia e token
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<ISecureLocalStorageService>(
    () => SecureStorageService(getIt<FlutterSecureStorage>()),
  );
}
