import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/favourites/data/datasources/favourites_local_data_source.dart';
import 'package:azores_weather/core/favourites/data/models/favourites_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  FavouritesLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = FavouritesLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getFavourites', () {
    final tFavouritesModel =
        FavouritesModel.fromJson(json.decode(fixture('favourites.json')));

    test(
      'should return Favourites from SharedPreferences when it is present',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('favourites.json'));
        // act
        final result = await dataSource.getFavourites();
        // assert
        verify(mockSharedPreferences.getString(FAVOURITES_CACHE));
        expect(result, equals(tFavouritesModel));
      },
    );

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource.getFavourites;
      // assert
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('addFavourite', () {
    final tFavouritesModel = FavouritesModel(list: ["Lagoa"]);
    final tSpotName = "Lagoa";

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.addFavourite(tSpotName);
      // assert
      final expectedJsonString = json.encode(tFavouritesModel.toJson());
      verify(mockSharedPreferences.setString(
          FAVOURITES_CACHE, expectedJsonString));
    });
  });

  group('removeFavourite', () {
    final tFavouritesModel = FavouritesModel(list: []);
    final tSpotName = "Lagoa";

    test('should call SharedPreferences to remove the data from the cache',
        () async {
      // act
      dataSource.removeFavourite(tSpotName);
      // assert
      final expectedJsonString = json.encode(tFavouritesModel.toJson());
      verify(mockSharedPreferences.setString(
          FAVOURITES_CACHE, expectedJsonString));
    });
  });
}
