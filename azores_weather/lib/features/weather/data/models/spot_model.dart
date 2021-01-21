import 'dart:math';

import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:flutter/material.dart';

class SpotModel extends Spot {
  SpotModel(
      {@required String name,
      @required int currentTemperature,
      @required int minTemperature,
      @required int maxTemperature,
      @required String weather,
      @required int humidity,
      @required int pressure})
      : super(
            name: name,
            currentTemperature: currentTemperature,
            minTemperature: minTemperature,
            maxTemperature: maxTemperature,
            weather: weather,
            humidity: humidity,
            pressure: pressure);

  factory SpotModel.fromJson(Map<String, dynamic> json) {
    return SpotModel(
        name: json['name'],
        currentTemperature: json['main']['temp'],
        minTemperature: json['main']['temp_min'],
        maxTemperature: json['main']['temp_max'],
        weather: json['weather'][0]['main'],
        humidity: json['main']['humidity'],
        pressure: json['main']['pressure']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "main": {
        "temp": currentTemperature,
        "temp_min": minTemperature,
        "temp_max": maxTemperature,
        "pressure": pressure,
        "humidity": humidity
      },
      "weather": [
        {"main": weather}
      ],
    };
  }
}
