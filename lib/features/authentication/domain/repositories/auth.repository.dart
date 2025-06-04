import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/features/authentication/domain/entities/access.token.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AccessToken>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? name,
  });

  Future<Either<Failure, void>> logout();
}