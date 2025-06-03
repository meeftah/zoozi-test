import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String accessToken;

  const User({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}