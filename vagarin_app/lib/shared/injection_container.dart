import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vagarin_app/core/auth/firebase_auth_service.dart';
import 'package:vagarin_app/core/auth/i_auth_service.dart';
import 'package:vagarin_app/core/services/i_secure_local_storage_service.dart';
import 'package:vagarin_app/core/services/secure_storage_service.dart';
import 'package:vagarin_app/core/services/storage/firebase_storage_service.dart';
import 'package:vagarin_app/core/services/storage/i_storage_service.dart';
import 'package:vagarin_app/features/register/data/repositories/i_user_repository.dart';
import 'package:vagarin_app/features/register/data/repositories/user_repository.dart';
import 'package:vagarin_app/features/register/presentation/stores/register_store.dart';

import '../core/api/auth_interceptor.dart';
import '../core/api/i_api_service.dart';
import '../core/api/spring_api_service.dart';
import '../core/router/app_router.dart';
import '../features/auth/stores/auth_store.dart';

final getIt = GetIt.instance;

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
);

void setupInjections() {
  // Básicos
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  getIt.registerLazySingleton<Logger>(() => logger);

  // Criptografia e token
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<ISecureLocalStorageService>(
    () => SecureStorageService(getIt<FlutterSecureStorage>()),
  );

  // Dio

  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(getIt<ISecureLocalStorageService>(), getIt<Logger>()),
  );

  const String ipLocal = '192.168.3.28';
  const String baseUrl = 'http://$ipLocal:8080/api/v1';

  final BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  getIt.registerLazySingleton<PrettyDioLogger>(
    () => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(baseOptions);
    if (kDebugMode) {
      dio.interceptors.add(getIt<PrettyDioLogger>());
    }
    dio.interceptors.add(getIt<AuthInterceptor>());
    return dio;
  });

  // Autenticação de usuário
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
  getIt.registerLazySingleton<IApiService>(() => SpringApiService());

  getIt.registerLazySingleton<IAuthService>(
    () => FirebaseAuthService(
      getIt<FirebaseAuth>(),
      getIt<ISecureLocalStorageService>(),
      getIt<GoogleSignIn>(),
      getIt<IApiService>(),
    ),
  );

  getIt.registerSingleton<AuthStore>(AuthStore(getIt<IAuthService>()));
  getIt.registerSingleton<AuthStateListenable>(AuthStateListenable());

  getIt.registerLazySingleton<IStorageService>(() => FirebaseStorageService());
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepository(getIt<IApiService>(), getIt<IStorageService>()),
  );

  getIt.registerLazySingleton<RegisterStore>(
    () => RegisterStore(
      getIt<IUserRepository>(),
      getIt<AuthStore>(),
      getIt<Logger>(),
    ),
  );
}
