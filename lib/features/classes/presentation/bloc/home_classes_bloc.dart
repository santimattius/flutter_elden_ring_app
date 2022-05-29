import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/character_repository.dart';
import 'package:flutter_elden_ring_app/features/classes/domain/class_character.dart';

part 'home_classes_event.dart';

part 'home_classes_state.dart';

class HomeClassesBloc extends Bloc<HomeClassesEvent, HomeClassesState> {
  final CharacterRepository repository;

  HomeClassesBloc(this.repository) : super(Init()) {
    on<HomeClassesEvent>((event, emit) async {
      emit(Loading());
      final result = await repository.getCharacters();
      final state = result.fold((l) => Error(message: ''), (r) => Loaded(r));
      emit(state);
    });
  }
}
