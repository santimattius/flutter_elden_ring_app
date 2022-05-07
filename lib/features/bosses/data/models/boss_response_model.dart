import 'dart:convert';

import 'package:flutter_elden_ring_app/features/bosses/data/models/boss_model.dart';

Response bossesResponseFromJson(String str) =>
    Response.fromJson(json.decode(str));

String bossesResponseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool success;
  final int count;
  final List<BossModel> data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null
            ? List.empty()
            : List<BossModel>.from(
                json["data"].map((x) => BossModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
