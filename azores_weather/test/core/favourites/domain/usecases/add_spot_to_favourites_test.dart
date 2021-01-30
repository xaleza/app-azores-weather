import 'package:azores_weather/core/favourites/domain/repositories/favourites_repository.dart';
import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavouritesRepository extends Mock implements FavouritesRepository {}

void main() {
  AddSpotToFavourites usecase;
  MockFavouritesRepository mockFavouritesRepository;

  setUp(() {
    mockFavouritesRepository = MockFavouritesRepository();
    usecase = AddSpotToFavourites(mockFavouritesRepository);
  });

  final tSpotName = 'Lagoa';

  test('should add a spot to the list of favourites', () async {
    // arrange
    when(mockFavouritesRepository.addSpotToFavourites(any))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await usecase(FavouritesParams(spotName: tSpotName));
    // assert
    expect(result, Right(null));
    verify(mockFavouritesRepository.addSpotToFavourites(tSpotName));
    verifyNoMoreInteractions(mockFavouritesRepository);
  });
}
