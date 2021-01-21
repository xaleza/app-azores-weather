import 'package:azores_weather/core/network/network_info.dart';
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

  SpotRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Spot>> getCurrentWeatherForSpot(String spotName) {
    // TODO: implement getCurrentWeatherForSpot
    throw UnimplementedError();
  }
}
