import 'package:azores_weather/features/weather/data/models/spot_model.dart';

abstract class SpotRemoteDataSource {
  /// Translates spotName into a city id
  /// Calls the api.openweathermap.org/data/2.5/weather?id={city id}&appid={API key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SpotModel> getCurrentWeatherForSpot(String spotName);
}
