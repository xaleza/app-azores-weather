import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/features/weather/data/models/spot_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const API_KEY = "0c07c51b5984e4bb4745cd6d4aaa8a42";

abstract class SpotRemoteDataSource {
  /// Calls the api.openweathermap.org/data/2.5/weather?id={spot id}&appid={API key}&units=metric endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SpotModel> getFreshWeatherForSpot(int spotId);
}

class SpotRemoteDataSourceImpl implements SpotRemoteDataSource {
  final http.Client client;

  SpotRemoteDataSourceImpl({@required this.client});

  @override
  Future<SpotModel> getFreshWeatherForSpot(int spotId) async {
    final response = await client.get(
      'api.openweathermap.org/data/2.5/weather?id=$spotId&appid=$API_KEY&units=metric',
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return SpotModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
