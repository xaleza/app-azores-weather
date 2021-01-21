// Translates city names to city ID's

import 'dart:convert';

import 'package:azores_weather/core/constants/constant_reader.dart';

abstract class CityIdsTranslator {
  int translate(String spotName);
}

class CityIdsTranslatorImpl implements CityIdsTranslator {
  @override
  int translate(String spotName) {
    final Map<String, dynamic> jsonMap = json.decode(constant('city_ids.json'));
    return jsonMap[spotName];
  }
}
