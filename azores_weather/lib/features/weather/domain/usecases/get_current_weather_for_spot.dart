import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/domain/repositories/spot_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GetCurrentWeatherForSpot extends UseCase<Spot, ParamsWeather> {
  final SpotRepository repository;

  GetCurrentWeatherForSpot(this.repository);

  Future<Either<Failure, Spot>> call(ParamsWeather params) async {
    return await repository.getCurrentWeatherForSpot(params.spotName);
  }
}

class ParamsWeather extends Equatable {
  final String spotName;

  ParamsWeather({@required this.spotName});

  @override
  List<Object> get props => [spotName];
}
