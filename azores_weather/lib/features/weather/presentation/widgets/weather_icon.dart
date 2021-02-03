import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

const CLEAR_WEATHER = "Clear";
const RAIN_WEATHER = "Rain";
const CLOUDS_WEATHER = "Clouds";
const DRIZZLE_WEATHER = "Drizzle";
const THUNDERSTORM_WEATHER = "Thunderstorm";
const SNOW_WEATHER = "Snow";
const MIST_WEATHER = "Mist";
const FOG_WEATHER = "Fog";

Icon weatherIcon(String weather) {
  switch (weather) {
    case THUNDERSTORM_WEATHER:
      return Icon(
        Ionicons.md_thunderstorm,
        color: Colors.grey,
      );
    case RAIN_WEATHER:
      return Icon(Ionicons.md_rainy, color: Colors.grey);
    case CLOUDS_WEATHER:
      return Icon(Ionicons.md_cloud, color: Colors.grey);
    case DRIZZLE_WEATHER:
      return Icon(Feather.cloud_drizzle, color: Colors.grey);
    case MIST_WEATHER:
      return Icon(MaterialCommunityIcons.weather_hazy, color: Colors.grey);
    case FOG_WEATHER:
      return Icon(MaterialCommunityIcons.weather_hazy, color: Colors.grey);
    case CLEAR_WEATHER:
      return Icon(
        Icons.wb_sunny,
        color: Colors.amber,
      );
    default:
      return Icon(Icons.error, color: Colors.red);
  }
}
