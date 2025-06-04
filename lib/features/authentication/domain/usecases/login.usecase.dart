import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/features/authentication/domain/entities/access.token.dart';
import 'package:zoozitest/features/authentication/domain/repositories/auth.repository.dart';

class LoginUseCase implements UseCase<AccessToken, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AccessToken>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}