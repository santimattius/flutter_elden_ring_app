import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';

abstract class BossesRepository {
  Future<Either<Failure, List<Boss>>> getBosses();
}
