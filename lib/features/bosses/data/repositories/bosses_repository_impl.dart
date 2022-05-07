import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/datasources/local_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/datasources/remote_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/models/boss_model.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/entities/bosse.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/repositories/bosses_repository.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';
import 'package:flutter_elden_ring_app/shared/network/network_info.dart';

class BossesRepositoryImpl implements BossesRepository {
  final BossesRemoteDataSource remoteDataSource;
  final BossesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BossesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Boss>>> getBosses() async {
    return await _getBosses(() async => await remoteDataSource.getBosses());
  }

  Future<Either<Failure, List<Boss>>> _getBosses(
      Future<List<Boss>> Function() call) async {
    if (await networkInfo.isConnected) {
      try {
        var remoteBosses = await call();
        localDataSource.cache(remoteBosses as List<BossModel>);
        return Right(remoteBosses);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        var localBosses = await localDataSource.getAll();
        return Right(localBosses);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
