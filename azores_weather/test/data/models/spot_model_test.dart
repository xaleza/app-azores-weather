import 'dart:convert';

import 'package:azores_weather/weather/data/models/spot_model.dart';
import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tSpotModel =
      SpotModel(name: 'Ponta Delgada', currentTemperature: 15, weather: 'Mist');

  test(
    'should be a subclass of Spot entity',
    () async {
      // assert
      expect(tSpotModel, isA<Spot>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('weather.json'));
        // act
        final result = SpotModel.fromJson(jsonMap);
        // assert
        expect(result, tSpotModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tSpotModel.toJson();
        // assert
        final expectedJsonMap = {
          "name": "Ponta Delgada",
          "main": {
            "temp": 15,
          },
          "weather": [
            {"main": "Mist"}
          ],
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
