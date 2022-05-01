import 'package:dartz/dartz.dart';
import 'package:flutter_arch_template/features/home/domain/usecases/get_bosses.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_bosses_bloc.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_bosses_event.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_bosses_state.dart';
import 'package:flutter_arch_template/shared/error/failures.dart';
import 'package:flutter_arch_template/shared/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../domain/boss_mother.dart';

class MockGetBosses extends Mock implements GetBosses {}

void main() {
  HomeBossesBloc bloc;
  MockGetBosses mockGetBosses;

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
        when(mockGetBosses(any))
            .thenAnswer((_) async => Left(ServerFailure()));
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
        when(mockGetBosses(any))
            .thenAnswer((_) async => Left(CacheFailure()));
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
