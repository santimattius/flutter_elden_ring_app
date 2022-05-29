import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/classes/data/classes_remote_data_source.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/character_repository.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/class_character.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';


class CharacterRepositoryImpl implements CharacterRepository {
  final ClassesRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Character>>> getCharacters() async {
    try {
      final characters = await remoteDataSource.getClasses();
      return Right(characters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
