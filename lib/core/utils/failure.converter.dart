import 'package:zoozitest/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server Failure";
    case CacheFailure:
      return "Cache Failure";
    case EmptyFailure:
      return "Empty Failure";
    case CredentialFailure:
      return "Wrong Email or Password";
    case NetworkFailure:
      return "No Internet Connection";
    default:
      return "Unexpected error";
  }
}