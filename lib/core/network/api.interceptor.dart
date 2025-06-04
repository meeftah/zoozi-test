import 'package:dio/dio.dart';
import 'package:zoozitest/core/constants/api.constants.dart';
import 'package:zoozitest/core/storage/secure.storage.dart';
import 'package:zoozitest/core/utils/logger.dart';

class ApiInterceptor extends Interceptor {
  final SecureStorage secureStorage;

  ApiInterceptor(this.secureStorage);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiConstants.baseUrl;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err.response?.statusCode);
    if (err.response?.statusCode == 401) {
      secureStorage.deleteToken();
    }
    super.onError(err, handler);
  }
}