import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Boss extends Equatable {
  final String id;
  final String name;
  final String   image;

  Boss({
    required this.id,
    required this.name,
    required this.image,
  }) : super();

  @override
  List<Object> get props => [id, name, image];
}
