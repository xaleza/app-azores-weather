import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:flutter/material.dart';

class FavouritesModel extends Favourites {
  FavouritesModel({@required List list}) : super(list: list);

  factory FavouritesModel.fromJson(Map<String, dynamic> json) {
    return FavouritesModel(list: json['favourites']);
  }

  Map<String, dynamic> toJson() {
    return {"favourites": list};
  }
}
