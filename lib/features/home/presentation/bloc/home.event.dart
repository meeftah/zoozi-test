import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetWalletsEvent extends HomeEvent {}

class AddWalletEvent extends HomeEvent {
  final String currency;
  final int initialBalance;

  const AddWalletEvent({required this.currency, required this.initialBalance});

  @override
  List<Object?> get props => [currency, initialBalance];
}
