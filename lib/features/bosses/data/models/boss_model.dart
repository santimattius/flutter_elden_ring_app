import 'dart:convert';

import 'package:flutter_elden_ring_app/features/bosses/domain/entities/bosse.dart';

List<BossModel> bossesFromJson(String str) =>
    List<BossModel>.from(json.decode(str).map((x) => BossModel.fromJson(x)));

String bossesToJson(List<BossModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BossModel extends Boss {
  BossModel({
    required id,
    required name,
    required image,
  }) : super(
          id: id,
          name: name,
          image: image,
        );

  factory BossModel.fromJson(Map<String, dynamic> json) => BossModel(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
