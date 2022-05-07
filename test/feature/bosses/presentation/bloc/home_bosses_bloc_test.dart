import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/bosses/domain/usecases/get_bosses.dart';
import 'package:flutter_elden_ring_app/features/bosses/presentation/bloc/home_bosses_bloc.dart';
import 'package:flutter_elden_ring_app/features/bosses/presentation/bloc/home_bosses_event.dart';
import 'package:flutter_elden_ring_app/features/bosses/presentation/bloc/home_bosses_state.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';
import 'package:flutter_elden_ring_app/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../domain/boss_mother.dart';
import 'home_bosses_bloc_test.mocks.dart';

@GenerateMocks([GetBosses])
void main() {
  late HomeBossesBloc bloc;
  late MockGetBosses mockGetBosses;

  setUp(() {
    mockGetBosses = MockGetBosses();

    bloc = HomeBossesBloc(
      getBosses: mockGetBosses,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Init()));
  });

  group('getBosses', () {
    final tBosses = BossMother.generate();

    test(
      'should get data from the get Bosses use case',
      () async {
        // arrange
        when(mockGetBosses(any)).thenAnswer((_) async => Right(tBosses));
        // act
        bloc.add(GetBossesEvent());
        await untilCalled(mockGetBosses(any));
        // assert
        verify(mockGetBosses(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetBosses(any)).thenAnswer((_) async => Right(tBosses));
        // assert later
        final expected = [
          Loading(),
          Loaded(bosses: tBosses),
        ];
        // act
        bloc.add(GetBossesEvent());
        // assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetBosses(any)).thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        // act
        bloc.add(GetBossesEvent());
        //assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetBosses(any)).thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        // act
        bloc.add(GetBossesEvent());
        // assert
        await expectLater(bloc.stream, emitsInOrder(expected));
      },
    );
  });
}
