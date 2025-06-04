import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/core/utils/failure.converter.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.add.usecase.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.get.usecase.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.event.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletGetUseCase getWalletsUseCase;
  final WalletAddUseCase addWalletUseCase;

  HomeBloc({
    required this.getWalletsUseCase,
    required this.addWalletUseCase,
  }) : super(HomeInitial()) {
    on<GetWalletsEvent>(_onGetWallets);
    on<AddWalletEvent>(_onAddWallet);
  }

  Future<void> _onGetWallets(GetWalletsEvent event, Emitter<HomeState> emit) async {
    emit(WalletLoadingState());
    final result = await getWalletsUseCase(NoParams());
    result.fold((failure) => emit(WalletErrorState(mapFailureToMessage(failure))), (wallets) => emit(WalletLoadedState(wallets)));
  }

  Future<void> _onAddWallet(AddWalletEvent event, Emitter<HomeState> emit) async {
    emit(WalletLoadingState());
    final result = await addWalletUseCase(WalletAddParams(currency: event.currency, initialBalance: event.initialBalance));

    result.fold((failure) => emit(WalletErrorState(mapFailureToMessage(failure))), (wallet) => emit(WalletAddedSuccessfully()));
    add(GetWalletsEvent());
  }
}
