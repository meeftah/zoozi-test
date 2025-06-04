import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';
import 'package:zoozitest/features/home/domain/repositories/wallet.repository.dart';

class WalletAddUseCase implements UseCase<Wallet, WalletAddParams> {
  final WalletRepository repository;

  WalletAddUseCase(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(WalletAddParams params) async {
    return await repository.addWallet(
      currency: params.currency,
      initialBalance: params.initialBalance,
    );
  }
}

class WalletAddParams {
  final String currency;
  final int initialBalance;

  WalletAddParams({
    required this.currency,
    required this.initialBalance,
  });
}