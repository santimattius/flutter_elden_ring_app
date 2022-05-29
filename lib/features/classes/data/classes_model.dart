import 'dart:convert';

import '../domain/class_character.dart';

ClassesResponse classesResponseFromJson(String str) =>
    ClassesResponse.fromJson(json.decode(str));

String classesResponseToJson(ClassesResponse data) =>
    json.encode(data.toJson());

class ClassesResponse {
  ClassesResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool success;
  final int count;
  final List<ClassModel> data;

  factory ClassesResponse.fromJson(Map<String, dynamic> json) =>
      ClassesResponse(
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null
            ? List.empty()
            : List<ClassModel>.from(
                json["data"].map((x) => ClassModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ClassModel extends Character {
  ClassModel({
    required id,
    required name,
    required image,
    required description,
    required this.stats,
  }) : super(
          id: id,
          name: name,
          image: image,
          description: description,
        );

  final Stats stats;

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
        stats: Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "stats": stats.toJson(),
      };
}

class Stats {
  Stats({
    required this.level,
    required this.vigor,
    required this.mind,
    required this.endurance,
    required this.strength,
    required this.dexterity,
    required this.inteligence,
    required this.faith,
    required this.arcane,
  });

  final String? level;
  final String? vigor;
  final String? mind;
  final String? endurance;
  final String? strength;
  final String? dexterity;
  final String? inteligence;
  final String? faith;
  final String? arcane;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        level: json["level"] == null ? null : json["level"],
        vigor: json["vigor"] == null ? null : json["vigor"],
        mind: json["mind"] == null ? null : json["mind"],
        endurance: json["endurance"] == null ? null : json["endurance"],
        strength: json["strength"] == null ? null : json["strength"],
        dexterity: json["dexterity"] == null ? null : json["dexterity"],
        inteligence: json["inteligence"] == null ? null : json["inteligence"],
        faith: json["faith"] == null ? null : json["faith"],
        arcane: json["arcane"] == null ? null : json["arcane"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "vigor": vigor,
        "mind": mind,
        "endurance": endurance,
        "strength": strength,
        "dexterity": dexterity,
        "inteligence": inteligence,
        "faith": faith,
        "arcane": arcane,
      };
}
