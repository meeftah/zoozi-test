import 'package:dio/dio.dart';
import '../constants/api.constants.dart';
import '../storage/secure.storage.dart';

class ApiInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  ApiInterceptor(this.secureStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip token for auth endpoints
    if (!options.path.contains('/auth/')) {
      final token = await secureStorage.getToken();
      if (token != null) {
        options.headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid - clear token
      secureStorage.deleteToken();
    }
    handler.next(err);
  }
}