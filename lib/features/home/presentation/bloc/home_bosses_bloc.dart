import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:flutter_elden_ring_app/features/home/domain/usecases/get_bosses.dart';
import 'package:flutter_elden_ring_app/shared/error/failures.dart';
import 'package:flutter_elden_ring_app/shared/usecases/usecase.dart';
import 'package:meta/meta.dart';

import 'home_bosses_event.dart';
import 'home_bosses_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class HomeBossesBloc extends Bloc<HomeEvent, HomeState> {
  final GetBosses getBosses;

  HomeBossesBloc({
    @required GetBosses getBosses,
  })  : assert(getBosses != null),
        this.getBosses = getBosses,
        super(Init()) {
    on<GetBossesEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(GetBossesEvent event, Emitter<HomeState> emit) async {
    emit(Loading());
    final failureOrBosses = await getBosses(
      NoParams(),
    );
    emit(_eitherAsState(failureOrBosses));
  }

  HomeState _eitherAsState(
    Either<Failure, List<Boss>> either,
  ) {
    return either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (bosses) => Loaded(bosses: bosses),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
