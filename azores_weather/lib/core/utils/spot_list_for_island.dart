// Translates city names to city ID's

import 'dart:convert';

import 'package:azores_weather/core/constants/constant_reader.dart';

Future<List> spotListForIsland(String islandName) async {
  final Map<String, dynamic> jsonMap =
      await json.decode(await constant('assets/islands_spots.json'));
  return jsonMap[islandName];
}
