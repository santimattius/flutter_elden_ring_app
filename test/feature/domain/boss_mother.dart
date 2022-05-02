import 'package:flutter_elden_ring_app/features/home/domain/entities/bosse.dart';

import '../data/boss_model_mother.dart';

abstract class BossMother {
  static List<Boss> generate() => List.generate(10, (index) => create());

  static Boss create() => Boss(
        id: "${TestingHelper.randomNumber()}",
        name: TestingHelper.getRandomString(20),
        image: TestingHelper.getRandomString(20),
      );
}
