import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/home/data/datasources/local_data_source.dart';
import 'package:flutter_elden_ring_app/features/home/data/datasources/remote_data_source.dart';
import 'package:flutter_elden_ring_app/features/home/data/repositories/bosses_repository_impl.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';
import 'package:flutter_elden_ring_app/shared/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../boss_model_mother.dart';

class MockRemoteDataSource extends Mock implements BossesRemoteDataSource {}

class MockLocalDataSource extends Mock implements BossesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  BossesRepositoryImpl repository;

  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = BossesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getBosses', () {
    final tBossesModels = BossModelMother.generate();
    final List<Boss> tBosses = tBossesModels;

    test('should che if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getBosses();

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should  return remote data when the call to remote data source is success',
          () async {
        when(mockRemoteDataSource.getBosses())
            .thenAnswer((_) async => tBossesModels);

        final result = await repository.getBosses();

        verify(mockRemoteDataSource.getBosses());
        expect(result, equals(Right(tBosses)));
      });

      test(
          'should  cache th data locally data when the call to remote data source is success',
          () async {
        when(mockRemoteDataSource.getBosses())
            .thenAnswer((_) async => tBossesModels);

        await repository.getBosses();

        verify(mockRemoteDataSource.getBosses());
        verify(mockLocalDataSource.cache(tBossesModels));
      });

      test(
          'should  return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getBosses()).thenThrow(ServerException());

        final result = await repository.getBosses();

        verify(mockRemoteDataSource.getBosses());

        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data whe the cached data is present',
          () async {
        when(mockLocalDataSource.getAll())
            .thenAnswer((_) async => tBossesModels);

        final result = await repository.getBosses();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAll());
        expect(result, equals(Right(tBosses)));
      });

      test('should return CacheFailure when there isno cached data present',
          () async {
        when(mockLocalDataSource.getAll()).thenThrow(CacheException());

        final result = await repository.getBosses();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getAll());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
