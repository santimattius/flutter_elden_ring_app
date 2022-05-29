import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/class_character.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters();
}
