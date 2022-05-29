import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/repositories/bosses_repository.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/usecases/get_bosses.dart';
import 'package:flutter_elden_ring_app/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../boss_mother.dart';
import 'get_bosses_test.mocks.dart';

@GenerateMocks([BossesRepository])
void main() {
  late GetBosses usecase;
  late MockBossesRepository mockBossesRepository;

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
