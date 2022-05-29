part of 'home_classes_bloc.dart';

abstract class HomeClassesState extends Equatable {
  final List<Object> _props;

  HomeClassesState([this._props = const <Object>[]]) : super();

  @override
  List<Object> get props => _props;
}

class Init extends HomeClassesState {}

class Empty extends HomeClassesState {}

class Loading extends HomeClassesState {}

class Loaded extends HomeClassesState {
  final List<Character> characters;

  Loaded(this.characters) : super([characters]);
}

class Error extends HomeClassesState {
  final String message;

  Error({required this.message}) : super([message]);
}
