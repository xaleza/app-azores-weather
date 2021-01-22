import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/data/datasources/favourites_local_data_source.dart';
import 'package:azores_weather/core/favourites/data/models/favourites_model.dart';
import 'package:azores_weather/core/favourites/data/repositories/favourites_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements FavouritesLocalDataSource {}

void main() {
  FavouritesRepositoryImpl repository;
  MockLocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockLocalDataSource();
    repository = FavouritesRepositoryImpl(localDataSource: mockDataSource);
  });

  final tFavouritesModel =
      FavouritesModel(list: ["Ponta Delgada", "Ribeira Grande"]);
  final tSpotName = "Ponta Delgada";
  final tFavourites = tFavouritesModel;

  group('getFavourites', () {
    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockDataSource.getFavourites())
            .thenAnswer((_) async => tFavouritesModel);
        // act
        final result = await repository.getFavourites();
        // assert
        verify(mockDataSource.getFavourites());
        expect(result, equals(Right(tFavourites)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        // arrange
        when(mockDataSource.getFavourites()).thenThrow(CacheException());
        // act
        final result = await repository.getFavourites();
        // assert
        verify(mockDataSource.getFavourites());
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });

  group('addSpotToFavourites', () {
    test(
      'should add a SpotName to favourites',
      () async {
        // act
        await repository.addSpotToFavourites(tSpotName);
        // assert
        verify(mockDataSource.addFavourite(tSpotName));
      },
    );

    test(
      'should return DuplicateFavouriteFailure when the spot was already added',
      () async {
        // arrange
        when(mockDataSource.addFavourite(tSpotName))
            .thenThrow(DuplicateFavouriteException());
        // act
        final result = await repository.addSpotToFavourites(tSpotName);
        // assert
        verify(mockDataSource.addFavourite(tSpotName));
        expect(result, equals(Left(DuplicateFavouriteFailure())));
      },
    );
  });

  group('removeSpotFromFavourites', () {
    test(
      'should remove a SpotName from favourites',
      () async {
        // act
        await repository.removeSpotFromFavourites(tSpotName);
        // assert
        verify(mockDataSource.removeFavourite(tSpotName));
      },
    );

    test(
      'should return MissingFavouriteFailure when the spot was already added',
      () async {
        // arrange
        when(mockDataSource.removeFavourite(tSpotName))
            .thenThrow(MissingFavouriteException());
        // act
        final result = await repository.removeSpotFromFavourites(tSpotName);
        // assert
        verify(mockDataSource.removeFavourite(tSpotName));
        expect(result, equals(Left(MissingFavouriteFailure())));
      },
    );
  });
}
