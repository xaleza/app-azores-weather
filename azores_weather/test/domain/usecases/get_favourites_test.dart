import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/weather/domain/entities/favourites.dart';
import 'package:azores_weather/weather/domain/repositories/favourites_repository.dart';
import 'package:azores_weather/weather/domain/usecases/get_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavouritesRepository extends Mock implements FavouritesRepository {}

void main() {
  GetFavourites usecase;
  MockFavouritesRepository mockFavouritesRepository;

  setUp(() {
    mockFavouritesRepository = MockFavouritesRepository();
    usecase = GetFavourites(mockFavouritesRepository);
  });

  final tSpotName1 = 'Lagoa';
  final tSpotName2 = 'Ponta Delgada';
  final tFavourites = Favourites(list: [tSpotName1, tSpotName2]);

  test('should get Favourites from repository', () async {
    // arrange
    when(mockFavouritesRepository.getFavourites())
        .thenAnswer((_) async => Right(tFavourites));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tFavourites));
    verify(mockFavouritesRepository.getFavourites());
    verifyNoMoreInteractions(mockFavouritesRepository);
  });
}
