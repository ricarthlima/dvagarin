import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vagarin_app/core/services/i_secure_local_storage_service.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';

import '../../shared/injection_container.dart';

class AuthInterceptor extends Interceptor {
  final ISecureLocalStorageService _localStorage;
  final Logger _logger;

  final List<String> _publicPaths = const ['/users/register'];

  AuthInterceptor(this._localStorage, this._logger);

  AuthStore get _authStore => getIt<AuthStore>();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Checa se a rota é pública
    if (_publicPaths.contains(options.path)) {
      _logger.d(
        '[AuthInterceptor] Rota pública, ignorando token: ${options.path}',
      );
      return handler.next(options);
    }

    // 2. Busca o token
    final token = await _localStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      _logger.d('[AuthInterceptor] Token anexado: ${options.path}');
    } else {
      _logger.w(
        '[AuthInterceptor] Token não encontrado para rota protegida: ${options.path}',
      );
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Lógica de tratamento de erro (401/403) - Logout automático
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      _logger.e(
        '[AuthInterceptor] 401/403 recebido. Token expirado/inválido. Forçando logout.',
      );
      _authStore.signOut();
      return handler.next(err);
    }

    return handler.next(err);
  }
}
