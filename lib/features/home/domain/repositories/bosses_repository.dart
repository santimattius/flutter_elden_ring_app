import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/domain/entities/bosse.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';

abstract class BossesRepository {
  Future<Either<Failure, List<Boss>>> getBosses();
}
