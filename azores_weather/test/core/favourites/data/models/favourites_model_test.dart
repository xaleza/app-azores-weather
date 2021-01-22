import 'dart:convert';

import 'package:azores_weather/core/favourites/data/models/favourites_model.dart';
import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFavouritesModel =
      FavouritesModel(list: ["Ponta Delgada", "Ribeira Grande"]);

  test(
    'should be a subclass of Favourites entity',
    () async {
      // assert
      expect(tFavouritesModel, isA<Favourites>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is a string',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('favourites.json'));
        // act
        final result = FavouritesModel.fromJson(jsonMap);
        // assert
        expect(result, tFavouritesModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tFavouritesModel.toJson();
        // assert
        final expectedJsonMap = {
          "favourites": ["Ponta Delgada", "Ribeira Grande"]
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
