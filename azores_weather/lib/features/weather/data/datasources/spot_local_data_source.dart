import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/features/weather/data/models/spot_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SpotLocalDataSource {
  /// Gets the cached [SpotModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<SpotModel> getCachedSpotWeather(String spotName);

  Future<void> cacheSpotWeather(SpotModel spotToCache);
}

class SpotLocalDataSourceImpl implements SpotLocalDataSource {
  final SharedPreferences sharedPreferences;

  SpotLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheSpotWeather(SpotModel spotToCache) {
    return sharedPreferences.setString(
      spotToCache.name,
      json.encode(spotToCache.toJson()),
    );
  }

  @override
  Future<SpotModel> getCachedSpotWeather(String spotName) {
    final jsonString = sharedPreferences.getString(spotName);
    if (jsonString != null) {
      return Future.value(SpotModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
