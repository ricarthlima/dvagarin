import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vagarin_app/core/api/i_api_service.dart';
import 'package:vagarin_app/shared/injection_container.dart';
import 'package:vagarin_app/shared/models/user_model.dart';

class SpringApiService implements IApiService {
  final Dio _dio = getIt<Dio>();
  final Logger _logger = getIt<Logger>();

  @override
  Future<UserModel?> checkUserRegistration() async {
    try {
      final response = await _dio.get('/users/me');

      if (response.statusCode == 200 && response.data != null) {
        _logger.d('[ApiService] /users/me OK');
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }
      _logger.w('[ApiService] /users/me 200 sem body');
      return null;
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      if (code == 401 || code == 403 || code == 404) {
        _logger.i('[ApiService] /users/me não encontrado (status $code)');
        return null; // "não registrado"
      }
      _logger.e(
        '[ApiService] /users/me erro de rede',
        error: e,
        stackTrace: e.stackTrace,
      );
      rethrow; // deixe estourar para o Store decidir o que fazer
    }
  }

  @override
  Future<UserModel> registerUser(Map<String, dynamic> userData) async {
    try {
      _logger.d('[ApiService] registerUser: Enviando dados: $userData');
      final response = await _dio.post('/users/register', data: userData);

      if (response.statusCode == 201 && response.data != null) {
        _logger.i(
          '[ApiService] registerUser: Usuário registrado com sucesso no backend.',
        );
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }
      _logger.w(
        '[ApiService] registerUser: Falha ao registrar (status ${response.statusCode})',
      );
      throw Exception(
        'Falha ao registrar usuário no backend (status ${response.statusCode})',
      );
    } on DioException catch (e, s) {
      // Capture StackTrace
      _logger.e('[ApiService] registerUser: Erro Dio', error: e, stackTrace: s);
      if (e.response?.statusCode == 400) {
        _logger.w(
          '[ApiService] registerUser: Erro 400 - Possível dado duplicado ou inválido: ${e.response?.data}',
        );
      }
      rethrow;
    } catch (e, s) {
      _logger.e(
        '[ApiService] registerUser: Erro inesperado',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
