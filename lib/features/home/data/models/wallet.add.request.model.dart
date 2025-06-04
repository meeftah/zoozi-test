import 'package:json_annotation/json_annotation.dart';

part 'wallet.add.request.model.g.dart';

@JsonSerializable()
class WalletAddRequestModel {
  final String currency;
  final int initialBalance;

  const WalletAddRequestModel({
    required this.currency,
    required this.initialBalance,
  });

  factory WalletAddRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WalletAddRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletAddRequestModelToJson(this);
}