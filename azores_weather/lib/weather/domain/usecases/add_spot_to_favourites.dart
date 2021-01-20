import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/weather/domain/repositories/spot_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddSpotToFavourites extends UseCase<void, Params> {
  final SpotRepository repository;

  AddSpotToFavourites(this.repository);

  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addSpotToFavourites(params.spotName);
  }
}

class Params extends Equatable {
  final String spotName;

  Params({@required this.spotName});

  @override
  List<Object> get props => [spotName];
}
