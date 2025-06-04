import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:zoozitest/core/error/exceptions.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/network/network.info.dart';
import 'package:zoozitest/core/storage/secure.storage.dart';
import 'package:zoozitest/features/authentication/data/datasources/auth.remote.data.source.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';
import 'package:zoozitest/features/authentication/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SecureStorage secureStorage;

  AuthRepositoryImpl({required this.remoteDataSource, required this.networkInfo, required this.secureStorage});

  @override
  Future<Either<Failure, User>> login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email: email, password: password);
        await secureStorage.saveToken(userModel.accessToken);
        return Right(userModel);
      } on AuthException {
        return Left(CredentialFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register({required String email, required String password, String? name}) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.register(email: email, password: password, name: name);
        return Right(userModel);
      } on AuthException {
        return Left(CredentialFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Clear local storage
      final secureStorage = SecureStorage();
      await secureStorage.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
