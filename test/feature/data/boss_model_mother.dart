import 'dart:math';

import 'package:flutter_elden_ring_app/features/home/data/models/boss_model.dart';

abstract class BossModelMother {
  static List<BossModel> generate() => List.generate(10, (index) => create());

  static BossModel create() => BossModel(
        id: "${TestingHelper.randomNumber()}",
        name: TestingHelper.getRandomString(20),
        image: TestingHelper.getRandomString(20),
      );

  static BossModel createSingle() => BossModel(
        id: "17f69d6ca41l0i1umlxg0j36mhrnzr",
        name: "Borealis The Freezing Fog",
        image: "https://eldenring.fanapis.com/images/bosses/17f69d6ca41l0i1umlxg0j36mhrnzr.png",
      );
}

abstract class TestingHelper {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static int randomNumber() {
    final random = Random();
    return random.nextInt(100);
  }

  static String getRandomString(int length) {
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length))));
  }
}
