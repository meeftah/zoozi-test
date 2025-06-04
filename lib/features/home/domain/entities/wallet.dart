import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final int id;
  final int userId;
  final int balance;
  final String currency;
  final String createdAt;
  final String updatedAt;

  const Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, balance, currency, createdAt, updatedAt];
}