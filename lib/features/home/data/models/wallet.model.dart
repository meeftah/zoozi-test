import 'package:json_annotation/json_annotation.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';

part 'wallet.model.g.dart';

@JsonSerializable()
class WalletModel extends Wallet {
  WalletModel({
    required int id,
    required int userId,
    required int balance,
    required String currency,
    required String createdAt,
    required String updatedAt,
  }) : super(
          id: id,
          userId: userId,
          balance: balance,
          currency: currency,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);

  factory WalletModel.fromEntity(Wallet wallet) {
    return WalletModel(
      id: wallet.id,
      userId: wallet.userId,
      balance: wallet.balance,
      currency: wallet.currency,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
    );
  }
}
