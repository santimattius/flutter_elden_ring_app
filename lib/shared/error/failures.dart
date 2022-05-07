import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<Object> _properties;

  Failure([this._properties = const <Object>[]]) : super();

  @override
  List<Object> get props => _properties;
}

//General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
