import 'package:azores_weather/weather/domain/repositories/spot_repository.dart';
import 'package:azores_weather/weather/domain/usecases/remove_spot_from_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSpotRepository extends Mock implements SpotRepository {}

void main() {
  RemoveSpotFromFavourites usecase;
  MockSpotRepository mockSpotRepository;

  setUp(() {
    mockSpotRepository = MockSpotRepository();
    usecase = RemoveSpotFromFavourites(mockSpotRepository);
  });

  final tSpotName = 'Lagoa';

  test('should remove a spot from the list of favourites', () async {
    // arrange
    when(mockSpotRepository.removeSpotFromFavourites(any))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await usecase(Params(spotName: tSpotName));
    // assert
    expect(result, Right(null));
    verify(mockSpotRepository.removeSpotFromFavourites(tSpotName));
    verifyNoMoreInteractions(mockSpotRepository);
  });
}
