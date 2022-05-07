import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  final List<Object> _props;

  HomeEvent([this._props = const <Object>[]]) : super();

  @override
  List<Object> get props => _props;
}

class GetBossesEvent extends HomeEvent {}

class FetchBosses extends HomeEvent {}
