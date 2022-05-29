import 'package:equatable/equatable.dart';

class Boss extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;

  Boss({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  }) : super();

  @override
  List<Object> get props => [id, name, image, description];
}
