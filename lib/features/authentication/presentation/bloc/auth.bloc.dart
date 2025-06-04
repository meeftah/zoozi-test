import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zoozitest/core/error/failures.dart';
import 'package:zoozitest/core/storage/secure.storage.dart';
import 'package:zoozitest/core/usecases/usecase.dart';
import 'package:zoozitest/core/utils/failure.converter.dart';
import 'package:zoozitest/features/authentication/domain/entities/access.token.dart';
import 'package:zoozitest/features/authentication/domain/usecases/login.usecase.dart';
import 'package:zoozitest/features/authentication/domain/usecases/logout.usecase.dart';
import 'package:zoozitest/features/authentication/domain/usecases/register.usecase.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.event.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase, required this.logoutUseCase}) : super(AuthInitialState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final result = await loginUseCase(LoginParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthErrorState(mapFailureToMessage(failure))), (user) => emit(AuthenticatedState(user)));
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final result = await registerUseCase(RegisterParams(email: event.email, password: event.password, name: event.name));

    result.fold((failure) => emit(AuthErrorState(failure.toString())), (user) => emit(RegisteredState()));
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final result = await logoutUseCase(NoParams());

    result.fold((failure) => emit(AuthErrorState(failure.toString())), (_) => emit(UnauthenticatedState()));
  }

  void _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final secureStorage = SecureStorage();
    final token = await secureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      final accessToken = AccessToken(accessToken: token);
      emit(AuthenticatedState(accessToken)); // you can also pass user data if needed
    } else {
      emit(UnauthenticatedState());
    }
    // emit(UnauthenticatedState());
  }
}
