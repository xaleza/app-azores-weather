import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/weather/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RemoveSpotFromFavourites extends UseCase<void, Params> {
  final FavouritesRepository repository;

  RemoveSpotFromFavourites(this.repository);

  Future<Either<Failure, void>> call(Params params) async {
    return await repository.removeSpotFromFavourites(params.spotName);
  }
}

class Params extends Equatable {
  final String spotName;

  Params({@required this.spotName});

  @override
  List<Object> get props => [spotName];
}
