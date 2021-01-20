import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:flutter/material.dart';

class SpotModel extends Spot {
  SpotModel(
      {@required String name,
      @required int currentTemperature,
      @required String weather})
      : super(
            name: name,
            currentTemperature: currentTemperature,
            weather: weather);
}
