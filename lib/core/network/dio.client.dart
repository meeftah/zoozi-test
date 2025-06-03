import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api.constants.dart';
import '../storage/secure.storage.dart';
import 'api.interceptor.dart';

class DioClient {
  late final Dio _dio;
  final SecureStorage secureStorage;

  DioClient(this.secureStorage) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': ApiConstants.contentType,
      },
    ));

    _dio.interceptors.addAll([
      ApiInterceptor(secureStorage),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  Dio get dio => _dio;
}