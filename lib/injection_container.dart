import 'package:flutter_elden_ring_app/features/bosses/data/datasources/local_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/datasources/remote_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/repositories/bosses_repository_impl.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/repositories/bosses_repository.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/usecases/get_bosses.dart';
import 'package:flutter_elden_ring_app/features/bosses/presentation/bloc/home_bosses_bloc.dart';
import 'package:flutter_elden_ring_app/shared/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  serviceLocator.registerFactory<HomeBossesBloc>(
    () => HomeBossesBloc(getBosses: serviceLocator()),
  );
  // Use cases
  serviceLocator.registerLazySingleton(() => GetBosses(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<BossesRepository>(
    () => BossesRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Data sources
  serviceLocator.registerLazySingleton<BossesRemoteDataSource>(
    () => BossesRemoteDataSourceImpl(client: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<BossesLocalDataSource>(
    () => SharedPreferencesLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  //! Share
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
