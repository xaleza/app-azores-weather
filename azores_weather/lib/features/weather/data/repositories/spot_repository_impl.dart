import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/network/network_info.dart';
import 'package:azores_weather/core/utils/city_ids_translator.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_local_data_source.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_remote_data_source.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/features/weather/domain/repositories/spot_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SpotRepositoryImpl implements SpotRepository {
  final SpotRemoteDataSource remoteDataSource;
  final SpotLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final CityIdsTranslator translator;

  SpotRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.translator,
  });

  @override
  Future<Either<Failure, Spot>> getCurrentWeatherForSpot(
      String spotName) async {
    int spotId = translator.translate(spotName);
    if (await networkInfo.isConnected) {
      try {
        final remoteSpot =
            await remoteDataSource.getFreshWeatherForSpot(spotId);
        localDataSource.cacheSpotWeather(remoteSpot);
        return Right(remoteSpot);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSpot = await localDataSource.getCachedSpotWeather(spotName);
        return Right(localSpot);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
