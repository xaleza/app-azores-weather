import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_local_data_source.dart';
import 'package:azores_weather/features/weather/data/models/spot_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SpotLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SpotLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tSpotName = "Ponta Delgada";

  group('getCachedSpotWeather', () {
    final tSpotModel =
        SpotModel.fromJson(json.decode(fixture('weather_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('weather_cached.json'));
        // act
        final result = await dataSource.getCachedSpotWeather(tSpotName);
        // assert
        verify(mockSharedPreferences.getString(tSpotName));
        expect(result, equals(tSpotModel));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource.getCachedSpotWeather;
      // assert
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(tSpotName), throwsA(isA<CacheException>()));
    });
  });

  group('cacheSpotWeather', () {
    final tSpotModel = SpotModel(
      currentTemperature: 15,
      humidity: 100,
      maxTemperature: 20,
      minTemperature: 10,
      name: "Ponta Delgada",
      pressure: 1014,
      weather: "Mist",
    );

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheSpotWeather(tSpotModel);
        // assert
        final expectedJsonString = json.encode(tSpotModel.toJson());
        verify(mockSharedPreferences.setString(
          tSpotName,
          expectedJsonString,
        ));
      },
    );
  });
}
