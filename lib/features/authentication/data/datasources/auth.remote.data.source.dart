import 'package:zoozitest/core/constants/api.constants.dart';
import 'package:zoozitest/core/constants/error.message.constants.dart';
import 'package:zoozitest/core/error/exceptions.dart';
import 'package:zoozitest/core/network/api.helper.dart';
import 'package:zoozitest/core/utils/logger.dart';
import 'package:zoozitest/features/authentication/data/models/login.request.model.dart';
import 'package:zoozitest/features/authentication/data/models/register.request.model.dart';
import 'package:zoozitest/features/authentication/data/models/token.model.dart';
import 'package:zoozitest/features/authentication/data/models/user.model.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login({required String email, required String password});

  Future<UserModel> register({required String email, required String password, String? name});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiHelper apiHelper;

  AuthRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<TokenModel> login({required String email, required String password}) async {
    try {
      final requestModel = LoginRequestModel(email: email, password: password);
      final response = await apiHelper.execute(method: Method.post, url: ApiConstants.login, data: requestModel.toJson());
      return TokenModel.fromJson(response);
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e.toString());
      if (e.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register({required String email, required String password, String? name}) async {
    try {
      final requestModel = RegisterRequestModel(email: email, password: password, name: name);
      final response = await apiHelper.execute(method: Method.post, url: ApiConstants.register, data: requestModel.toJson());
      return UserModel.fromJson(response);
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }
}
