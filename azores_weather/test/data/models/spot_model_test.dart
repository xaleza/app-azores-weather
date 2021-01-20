import 'package:azores_weather/weather/data/models/spot_model.dart';
import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSpotModel = SpotModel(
      name: 'spotName', currentTemperature: 15, weather: 'test weather');

  test(
    'should be a subclass of Spot entity',
    () async {
      // assert
      expect(tSpotModel, isA<Spot>());
    },
  );
}
