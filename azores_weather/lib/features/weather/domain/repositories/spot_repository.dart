import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:dartz/dartz.dart';

abstract class SpotRepository {
  Future<Either<Failure, Spot>> getCurrentWeatherForSpot(String spotName);
}
