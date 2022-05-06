import 'package:equatable/equatable.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  final List<Object> _props;

  HomeState([this._props = const <Object>[]]) : super();

  @override
  List<Object> get props => _props;
}

class Init extends HomeState {}

class Empty extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<Boss> bosses;

  Loaded({@required this.bosses}) : super([bosses]);
}

class Error extends HomeState {
  final String message;

  Error({@required this.message}) : super([message]);
}
