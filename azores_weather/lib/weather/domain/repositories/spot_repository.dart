import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:dartz/dartz.dart';

abstract class SpotRepository {
  Future<Either<Failure, Spot>> getCurrentWeatherForSpot(String spotName);
  Future<Either<Failure, void>> addSpotToFavourites(String spotName);
  Future<Either<Failure, void>> removeSpotFromFavourites(String spotName);
}
