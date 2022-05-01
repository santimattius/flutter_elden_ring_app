import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/data/datasources/local_data_source.dart';
import 'package:flutter_arch_template/features/home/data/datasources/remote_data_source.dart';
import 'package:flutter_arch_template/features/home/domain/entities/bosse.dart';
import 'package:flutter_arch_template/features/home/domain/repositories/bosses_repository.dart';
import 'package:flutter_arch_template/shared/error/exceptions.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/network/network_info.dart';
import 'package:meta/meta.dart';

class BossesRepositoryImpl implements BossesRepository {
  final BossesRemoteDataSource remoteDataSource;
  final BossesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BossesRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, List<Boss>>> getBosses() async {
    return await _getBosses(() async => await remoteDataSource.getBosses());
  }

  Future<Either<Failure, List<Boss>>> _getBosses(
      Future<List<Boss>> Function() call) async {
    if (await networkInfo.isConnected) {
      try {
        var remoteBosses = await call();
        localDataSource.cache(remoteBosses);
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
