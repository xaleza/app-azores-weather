import 'package:azores_weather/features/weather/data/models/spot_model.dart';

abstract class SpotLocalDataSource {
  /// Gets the cached [SpotModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<SpotModel> getLastSpotWeather();

  Future<void> cacheNumberTrivia(SpotModel spotToCache);
}
