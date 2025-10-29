import 'package:dio/dio.dart';
import 'package:logger/web.dart';

import '../../features/auth/stores/auth_store.dart';
import '../../shared/injection_container.dart';
import '../services/i_secure_local_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final ISecureLocalStorageService _localStorage;
  final Logger _logger;

  // rotas realmente públicas (sem Authorization)
  final List<String> _publicPaths = const ['/users/register'];

  // rotas que podem retornar 401/403 legitimamente no fluxo de onboarding/registro
  final Set<String> _registrationFlowPaths = const {
    '/users/me', // checagem de existência no backend
    '/users/register', // criação no backend
  };

  AuthInterceptor(this._localStorage, this._logger);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_publicPaths.contains(options.path)) {
      _logger.d('[AuthInterceptor] Rota pública (sem token): ${options.path}');
      return handler.next(options);
    }

    final token = await _localStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      _logger.d('[AuthInterceptor] Token anexado: ${options.path}');
    } else {
      _logger.w(
        '[AuthInterceptor] Sem token para rota protegida: ${options.path}',
      );
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final path = err.requestOptions.path;
    final code = err.response?.statusCode;

    if ((code == 401 || code == 403)) {
      // NÃO deslogar se for endpoint do fluxo de registro/checagem
      if (_registrationFlowPaths.contains(path)) {
        _logger.i(
          '[AuthInterceptor] $code em $path durante registro: NÃO deslogar.',
        );
        return handler.next(err);
      }

      _logger.e(
        '[AuthInterceptor] $code em $path. Forçando logout (token inválido/expirado).',
      );
      getIt<AuthStore>().signOut();
      return handler.next(err);
    }

    handler.next(err);
  }
}
