import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/favourites/data/models/favourites_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const FAVOURITES_CACHE = 'favourites';

abstract class FavouritesLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<FavouritesModel> getFavourites();

  Future<void> addFavourite(String spotName);

  Future<void> removeFavourite(String spotName);
}

class FavouritesLocalDataSourceImpl implements FavouritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavouritesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> addFavourite(String spotName) async {
    var favouriteToCache;
    final jsonString = sharedPreferences.getString(FAVOURITES_CACHE);
    if (jsonString == null) {
      favouriteToCache = FavouritesModel(list: [spotName]);
      sharedPreferences.setString(
          FAVOURITES_CACHE, json.encode(favouriteToCache.toJson()));
    } else {
      favouriteToCache =
          await Future.value(FavouritesModel.fromJson(json.decode(jsonString)));
      favouriteToCache.addFavourite(spotName);
    }
    return sharedPreferences.setString(
      FAVOURITES_CACHE,
      json.encode(favouriteToCache.toJson()),
    );
  }

  @override
  Future<FavouritesModel> getFavourites() {
    final jsonString = sharedPreferences.getString(FAVOURITES_CACHE);
    if (jsonString != null) {
      return Future.value(FavouritesModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeFavourite(String spotName) async {
    var favouriteToCache;
    final jsonString = sharedPreferences.getString(FAVOURITES_CACHE);
    if (jsonString == null) {
      favouriteToCache = FavouritesModel(list: []);
    } else {
      favouriteToCache =
          await Future.value(FavouritesModel.fromJson(json.decode(jsonString)));
      favouriteToCache.removeFavourite(spotName);
    }
    return sharedPreferences.setString(
      FAVOURITES_CACHE,
      json.encode(favouriteToCache.toJson()),
    );
  }
}
