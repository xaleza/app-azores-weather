import 'package:azores_weather/weather/domain/repositories/spot_repository.dart';
import 'package:azores_weather/weather/domain/usecases/add_spot_to_favourites.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSpotRepository extends Mock implements SpotRepository {}

void main() {
  AddSpotToFavourites usecase;
  MockSpotRepository mockSpotRepository;

  setUp(() {
    mockSpotRepository = MockSpotRepository();
    usecase = AddSpotToFavourites(mockSpotRepository);
  });

  final tSpotName = 'Lagoa';

  test('should add a spot to the list of favourites', () async {
    // arrange
    when(mockSpotRepository.addSpotToFavourites(any))
        .thenAnswer((_) async => Right(null));
    // act
    final result = await usecase(Params(spotName: tSpotName));
    // assert
    expect(result, Right(null));
    verify(mockSpotRepository.addSpotToFavourites(tSpotName));
    verifyNoMoreInteractions(mockSpotRepository);
  });
}
