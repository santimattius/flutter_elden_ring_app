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

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerFactory<HomeBossesBloc>(
    () => HomeBossesBloc(getBosses: sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetBosses(sl()));

  // Repository
  sl.registerLazySingleton<BossesRepository>(
    () => BossesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<BossesRemoteDataSource>(
    () => BossesRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<BossesLocalDataSource>(
    () => SharedPreferencesLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Share
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
