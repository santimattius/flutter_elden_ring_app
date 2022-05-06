import 'package:flutter_elden_ring_app/features/home/data/models/boss_model.dart';
import 'package:flutter_elden_ring_app/features/home/data/models/boss_response_model.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class BossesRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<BossModel>> getBosses();
}

class BossesRemoteDataSourceImpl implements BossesRemoteDataSource {
  final http.Client client;

  BossesRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<BossModel>> getBosses() async {
    return _getBossesUrl('https://eldenring.fanapis.com/api/bosses?limit=100');
  }

  Future<List<BossModel>> _getBossesUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return bossesResponseFromJson(response.body).data;
    } else {
      throw ServerException();
    }
  }
}
