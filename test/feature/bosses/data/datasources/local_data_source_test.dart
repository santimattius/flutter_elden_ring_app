import 'package:flutter_elden_ring_app/features/bosses/data/datasources/local_data_source.dart';
import 'package:flutter_elden_ring_app/features/bosses/data/models/boss_model.dart';
import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../boss_model_mother.dart';
import 'local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late SharedPreferencesLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SharedPreferencesLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getAllBosses', () {
    final bosses = bossesFromJson(fixture('bosses_data.json'));
    test(
        'should return list of bosses from SharedPreferences when there is one in the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('bosses_data.json'));

      final result = await dataSource.getAll();

      verify(mockSharedPreferences.getString(CACHED_BOSSES));
      expect(result, equals(bosses));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getAll;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache', () {
    final tBossModel = BossModelMother.generate();

    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(CACHED_BOSSES, any))
          .thenAnswer((realInvocation) => Future.value(true));
      dataSource.cache(tBossModel);
      final expectedJsonString = bossesToJson(tBossModel);

      verify(
          mockSharedPreferences.setString(CACHED_BOSSES, expectedJsonString));
    });
  });
}
