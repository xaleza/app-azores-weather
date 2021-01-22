import 'package:azores_weather/core/favourites/data/models/favourites_model.dart';

abstract class FavouritesLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<FavouritesModel> getFavourites();

  Future<void> addFavourite(String spotName);

  Future<void> removeFavourite(String spotName);
}
