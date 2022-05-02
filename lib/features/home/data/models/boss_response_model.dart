import 'dart:convert';

import 'package:flutter_elden_ring_app/features/home/data/models/boss_model.dart';

Response bossesResponseFromJson(String str) =>
    Response.fromJson(json.decode(str));

String bossesResponseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.success,
    this.count,
    this.data,
  });

  final bool success;
  final int count;
  final List<BossModel> data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null
            ? null
            : List<BossModel>.from(
                json["data"].map((x) => BossModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "count": count == null ? null : count,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
