import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/domain/repositories/bosses_repository.dart';
import 'package:flutter_arch_template/features/home/domain/usecases/get_bosses.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../boss_mother.dart';

class MockBossesRepository extends Mock implements BossesRepository {}

void main() {
  GetBosses usecase;
  MockBossesRepository mockBossesRepository;

  setUp(() {
    mockBossesRepository = MockBossesRepository();
    usecase = GetBosses(mockBossesRepository);
  });

  final tBosses = BossMother.generate();

  test(
    'should get bosses from the repository',
    () async {
      when(mockBossesRepository.getBosses())
          .thenAnswer((_) async => Right(tBosses));

      final result = await usecase(NoParams());

      expect(result, Right(tBosses));
      verify(mockBossesRepository.getBosses());
      verifyNoMoreInteractions(mockBossesRepository);
    },
  );
}
