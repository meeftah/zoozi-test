import 'package:equatable/equatable.dart';
import 'package:zoozitest/features/authentication/domain/entities/access.token.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AccessToken accessToken;

  const AuthenticatedState(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class RegisteredState extends AuthState {}