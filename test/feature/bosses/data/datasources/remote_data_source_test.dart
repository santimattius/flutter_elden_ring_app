import 'package:flutter_elden_ring_app/features/bosses/data/datasources/remote_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/models/boss_model.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late BossesRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = BossesRemoteDataSourceImpl(client: mockHttpClient);
  });

  const _URL = 'https://eldenring.fanapis.com/api/bosses?limit=100';

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('data.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getBosses', () {
    final tBossModel = bossesFromJson(fixture('bosses_data.json'))
        .where((element) => element.image.isNotEmpty)
        .toList();

    test('''should perform a GET request on a URL with number 
    being the endpoint and with application/json header''', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getBosses();

      verify(mockHttpClient
          .get(Uri.parse(_URL), headers: {'Content-Type': 'application/json'}));
    });

    test('should return list of bosses when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getBosses();

      expect(result, equals(tBossModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getBosses;

      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
