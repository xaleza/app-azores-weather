import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:azores_weather/weather/domain/repositories/spot_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GetCurrentWeatherForSpot extends UseCase<Spot, Params> {
  final SpotRepository repository;

  GetCurrentWeatherForSpot(this.repository);

  Future<Either<Failure, Spot>> call(Params params) async {
    return await repository.getCurrentWeatherForSpot(params.spotName);
  }
}

class Params extends Equatable {
  final String spotName;

  Params({@required this.spotName});

  @override
  List<Object> get props => [spotName];
}
