import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/favourites/data/datasources/favourites_local_data_source.dart';
import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final FavouritesLocalDataSource localDataSource;

  FavouritesRepositoryImpl({@required this.localDataSource});

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> addSpotToFavourites(String spotName) async {
    try {
      await localDataSource.addFavourite(spotName);
    } on DuplicateFavouriteException {
      return Left(DuplicateFavouriteFailure());
    }
  }

  @override
  Future<Either<Failure, Favourites>> getFavourites() async {
    try {
      final favourites = await localDataSource.getFavourites();
      return Right(favourites);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> removeSpotFromFavourites(
      String spotName) async {
    try {
      await localDataSource.removeFavourite(spotName);
    } on MissingFavouriteException {
      return Left(MissingFavouriteFailure());
    }
  }
}
