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

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      secureStorage: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiHelper: sl()), // Updated to use apiHelper
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