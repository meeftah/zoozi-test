import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';
import 'package:zoozitest/features/authentication/domain/repositories/auth.repository.dart';

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String? name;

  RegisterParams({
    required this.email,
    required this.password,
    this.name,
  });
}