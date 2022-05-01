import 'dart:convert';

import 'package:flutter_arch_template/features/home/domain/entities/bosse.dart';
import 'package:meta/meta.dart';

List<BossModel> fromJson(String str) =>
    List<BossModel>.from(json.decode(str).map((x) => BossModel.fromJson(x)));

String toJson(List<BossModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BossModel extends Boss {
  BossModel({
    @required id,
    @required name,
    @required image,
  }) : super(
          id: id,
          name: name,
          image: image,
        );

  factory BossModel.fromJson(Map<String, dynamic> json) => BossModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
