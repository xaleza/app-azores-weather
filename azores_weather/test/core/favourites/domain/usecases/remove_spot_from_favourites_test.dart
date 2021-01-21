import 'package:azores_weather/core/favourites/domain/repositories/favourites_repository.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavouritesRepository extends Mock implements FavouritesRepository {}

void main() {
  RemoveSpotFromFavourites usecase;
  MockFavouritesRepository mockFavouritesRepository;

  setUp(() {
    mockFavouritesRepository = MockFavouritesRepository();
    usecase = RemoveSpotFromFavourites(mockFavouritesRepository);
  });

  final tSpotName = 'Lagoa';

  test('should remove a spot from the list of favourites', () async {
    // arrange
    when(mockFavouritesRepository.removeSpotFromFavourites(any))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await usecase(Params(spotName: tSpotName));
    // assert
    expect(result, Right(null));
    verify(mockFavouritesRepository.removeSpotFromFavourites(tSpotName));
    verifyNoMoreInteractions(mockFavouritesRepository);
  });
}
