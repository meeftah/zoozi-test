import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';
import 'package:zoozitest/features/home/domain/repositories/wallet.repository.dart';

class WalletGetUseCase implements UseCase<List<Wallet>, NoParams> {
  final WalletRepository repository;

  WalletGetUseCase(this.repository);

  @override
  Future<Either<Failure, List<Wallet>>> call(NoParams params) async {
    return await repository.listWallet();
  }
}