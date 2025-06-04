import 'package:dartz/dartz.dart';
import 'package:zoozitest/core/error/exceptions.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/network/network.info.dart';
import 'package:zoozitest/features/home/data/datasources/wallet.remote.data.source.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';
import 'package:zoozitest/features/home/domain/repositories/wallet.repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Wallet>> addWallet({required String currency, required int initialBalance}) async {
    if (await networkInfo.isConnected) {
      try {
        final walletModel = await remoteDataSource.addWallet(currency: currency, initialBalance: initialBalance);
        return Right(walletModel);
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
  Future<Either<Failure, List<Wallet>>> listWallet() async {
    if (await networkInfo.isConnected) {
      try {
        final walletModels = await remoteDataSource.listWallet();
        return Right(walletModels);
      } on AuthException {
        return Left(CredentialFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
