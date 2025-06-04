import 'package:dio/dio.dart';
import 'package:zoozitest/core/constants/api.constants.dart';
import 'package:zoozitest/core/utils/logger.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiConstants.baseUrl;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err.response?.statusCode);
    super.onError(err, handler);
  }
}