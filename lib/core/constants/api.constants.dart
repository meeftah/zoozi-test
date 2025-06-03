class ApiConstants {
  static const String baseUrl = 'https://wallet-testing-murex.vercel.app';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  
  // Wallet endpoints
  static const String wallets = '/wallets';
  static const String walletDetails = '/wallets/{id}';
  
  // Transaction endpoints
  static const String deposit = '/wallets/{walletId}/transactions/deposit';
  static const String withdrawal = '/wallets/{walletId}/transactions/withdrawal';
  static const String transactions = '/wallets/{walletId}/transactions';
  static const String transactionDetails = '/wallets/{walletId}/transactions/{id}';
  
  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}