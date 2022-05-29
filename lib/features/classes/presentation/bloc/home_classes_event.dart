part of 'home_classes_bloc.dart';

abstract class HomeClassesEvent extends Equatable {
  final List<Object> _props;

  HomeClassesEvent([this._props = const <Object>[]]) : super();

  @override
  List<Object> get props => _props;
}

class GetCharactersEvent extends HomeClassesEvent {}
