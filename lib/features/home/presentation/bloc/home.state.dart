import 'package:equatable/equatable.dart';
import 'package:zoozitest/features/home/domain/entities/wallet.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class WalletLoadingState extends HomeState {}

class WalletLoadedState extends HomeState {
  final List<Wallet> wallets;

  const WalletLoadedState(this.wallets);

  @override
  List<Object?> get props => [wallets];
}

class WalletErrorState extends HomeState {
  final String message;

  const WalletErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class WalletAddedSuccessfully extends HomeState {}
