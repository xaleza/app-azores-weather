import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/repositories/favourites_repository.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddSpotToFavourites extends UseCase<void, FavouritesParams> {
  final FavouritesRepository repository;

  AddSpotToFavourites(this.repository);

  Future<Either<Failure, void>> call(FavouritesParams params) async {
    return await repository.addSpotToFavourites(params.spotName);
  }
}

class FavouritesParams extends Equatable {
  final String spotName;

  FavouritesParams({@required this.spotName});

  @override
  List<Object> get props => [spotName];
}
