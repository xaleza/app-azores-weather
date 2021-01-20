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

  factory SpotModel.fromJson(Map<String, dynamic> json) {
    return SpotModel(
        name: json['name'],
        currentTemperature: json['main']['temp'],
        weather: json['weather'][0]['main']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "main": {
        "temp": currentTemperature,
      },
      "weather": [
        {"main": weather}
      ],
    };
  }
}
