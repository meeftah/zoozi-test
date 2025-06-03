class ServerException implements Exception {
  final String message;
  
  const ServerException(this.message);
}

class NetworkException implements Exception {
  const NetworkException();
}

class CacheException implements Exception {
  const CacheException();
}

class AuthenticationException implements Exception {
  final String message;
  
  const AuthenticationException(this.message);
}