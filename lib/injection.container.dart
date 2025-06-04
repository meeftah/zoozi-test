// di.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zoozitest/core/network/api.helper.dart';
import 'package:zoozitest/core/network/api.interceptor.dart';
import 'package:zoozitest/core/network/network.info.dart';
import 'package:zoozitest/core/storage/secure.storage.dart';
import 'package:zoozitest/features/authentication/data/datasources/auth.remote.data.source.dart';
import 'package:zoozitest/features/authentication/data/repositories/auth.repository.impl.dart';
import 'package:zoozitest/features/authentication/domain/repositories/auth.repository.dart';
import 'package:zoozitest/features/authentication/domain/usecases/login.usecase.dart';
import 'package:zoozitest/features/authentication/domain/usecases/logout.usecase.dart';
import 'package:zoozitest/features/authentication/domain/usecases/register.usecase.dart';
import 'package:zoozitest/features/authentication/presentation/bloc/auth.bloc.dart';
import 'package:zoozitest/features/home/data/datasources/wallet.remote.data.source.dart';
import 'package:zoozitest/features/home/data/repositories/wallet.repository.impl.dart';
import 'package:zoozitest/features/home/domain/repositories/wallet.repository.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.add.usecase.dart';
import 'package:zoozitest/features/home/domain/usecases/wallet.get.usecase.dart';
import 'package:zoozitest/features/home/presentation/bloc/home.bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  await _initCore();
  
  //! External
  await _initExternal();
  
  //! Features
  await _initAuth(); // Must come after core and external
}

Future<void> _initAuth() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    registerUseCase: sl(),
    logoutUseCase: sl(),
  ));
  sl.registerFactory(() => HomeBloc(
    getWalletsUseCase: sl(),
    addWalletUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => WalletAddUseCase(sl()));
  sl.registerLazySingleton(() => WalletGetUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      secureStorage: sl(),
    ),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiHelper: sl()), // Updated to use apiHelper
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(apiHelper: sl()), // Updated to use apiHelper
  );
}

Future<void> _initCore() async {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => SecureStorage());
}

Future<void> _initExternal() async {
  // Add Dio registration
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    // Add your interceptors here
    dio.interceptors.add(ApiInterceptor(sl()));
    return dio;
  });
  
  sl.registerLazySingleton(() => ApiHelper(sl())); // Now correctly gets Dio
  sl.registerLazySingleton(() => Connectivity());
}