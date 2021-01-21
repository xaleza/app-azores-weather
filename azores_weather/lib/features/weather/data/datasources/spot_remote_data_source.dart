import 'package:azores_weather/features/weather/data/models/spot_model.dart';

abstract class SpotRemoteDataSource {
  /// Calls the api.openweathermap.org/data/2.5/weather?id={spot id}&appid={API key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SpotModel> getFreshWeatherForSpot(int spotId);
}
