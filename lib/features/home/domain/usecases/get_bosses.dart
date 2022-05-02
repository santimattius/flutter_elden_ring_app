import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:flutter_elden_ring_app/features/home/domain/repositories/bosses_repository.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';
import 'package:flutter_elden_ring_app/shared/usecases/usecase.dart';

class GetBosses implements UseCase<List<Boss>, NoParams> {
  final BossesRepository repository;

  GetBosses(this.repository);

  @override
  Future<Either<Failure, List<Boss>>> call(NoParams params) async {
    return await repository.getBosses();
  }
}
