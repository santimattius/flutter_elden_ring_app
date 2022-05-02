import 'dart:convert';

import 'package:flutter_elden_ring_app/features/home/data/models/boss_model.dart';
import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';
import '../boss_model_mother.dart';

void main() {
  final tBossModel = BossModelMother.createSingle();

  test('should be a subclass of boss entity', () async {
    expect(tBossModel, isA<Boss>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('boss.json'));

      final result = BossModel.fromJson(jsonMap);

      expect(result, tBossModel);
    });
  });

  group('toJson', () {
    test('should return as Json map containing the proper data', () async {
      final result = tBossModel.toJson();

      final expectedMap = {
        "id": "0",
        "name": "Alejandro Escamilla",
        "image": "https://unsplash.com/photos/yC-Yzbqy7PY",
      };
      expect(result, expectedMap);
    });
  });
}
