import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/features/authentication/domain/entities/access.token.dart';
import 'package:zoozitest/features/authentication/domain/entities/user.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> addWallet({
    required String currency,
    required int initialBalance,
  });

  Future<Either<Failure, List<Wallet>>> listWallet();
}