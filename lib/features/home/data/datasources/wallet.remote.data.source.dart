import 'dart:convert';

import 'package:zoozitest/core/constants/api.constants.dart';
import 'package:zoozitest/core/constants/error.message.constants.dart';
import 'package:zoozitest/core/error/exceptions.dart';
import 'package:zoozitest/core/network/api.helper.dart';
import 'package:zoozitest/core/utils/logger.dart';
import 'package:zoozitest/features/home/data/models/wallet.add.request.model.dart';
import 'package:zoozitest/features/home/data/models/wallet.model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> addWallet({required String currency, required int initialBalance});
  Future<List<WalletModel>> listWallet();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiHelper apiHelper;

  WalletRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<WalletModel> addWallet({required String currency, required int initialBalance}) async {
    try {
      final requestModel = WalletAddRequestModel(currency: currency, initialBalance: initialBalance);
      final response = await apiHelper.execute(method: Method.post, url: ApiConstants.wallets, data: requestModel.toJson());
      return WalletModel.fromJson(response);
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
  Future<List<WalletModel>> listWallet() async {
    try {
      final response = await apiHelper.execute(method: Method.get, url: ApiConstants.wallets);

      // Extract the list from the map (adjust key name as needed)
      final List<dynamic> walletList = response['data'] ?? response['wallets'] ?? [];

      return walletList.map((item) => WalletModel.fromJson(item as Map<String, dynamic>)).toList();
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
