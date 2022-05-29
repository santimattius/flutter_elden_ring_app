import 'package:flutter_elden_ring_app/features/classes/data/classes_model.dart';
import 'package:flutter_elden_ring_app/shared/network/client.dart';

abstract class ClassesRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<List<ClassModel>> getClasses();
}

class ClassesRemoteDataSourceImpl implements ClassesRemoteDataSource {
  final ApiClient _client;

  ClassesRemoteDataSourceImpl(this._client);

  @override
  Future<List<ClassModel>> getClasses() async {
    final response = await _client.get("classes");
    final data = classesResponseFromJson(response);
    return data.data;
  }
}
