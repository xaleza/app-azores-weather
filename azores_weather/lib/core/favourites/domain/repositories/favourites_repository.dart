import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:dartz/dartz.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, void>> addSpotToFavourites(String spotName);
  Future<Either<Failure, void>> removeSpotFromFavourites(String spotName);
  Future<Either<Failure, Favourites>> getFavourites();
}
