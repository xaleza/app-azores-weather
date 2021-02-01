// Translates city names to city ID's

import 'dart:convert';

import 'package:azores_weather/core/constants/constant_reader.dart';

abstract class CityIdsTranslator {
  Future<int> translate(String spotName);
}

class CityIdsTranslatorImpl implements CityIdsTranslator {
  @override
  Future<int> translate(String spotName) async {
    final Map<String, dynamic> jsonMap =
        await json.decode(await constant('assets/city_ids.json'));
    return jsonMap[spotName];
  }
}
