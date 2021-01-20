import 'package:azores_weather/weather/domain/entities/spot.dart';
import 'package:azores_weather/weather/domain/repositories/spot_repository.dart';
import 'package:azores_weather/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSpotRepository extends Mock implements SpotRepository {}

void main() {
  GetCurrentWeatherForSpot usecase;
  MockSpotRepository mockSpotRepository;

  setUp(() {
    mockSpotRepository = MockSpotRepository();
    usecase = GetCurrentWeatherForSpot(mockSpotRepository);
  });

  final tSpotName = 'Lagoa';
  final tTemperature = 15;
  final tWeather = 'Sunny';

  final tSpot = Spot(
    name: tSpotName,
    currentTemperature: tTemperature,
    weather: tWeather,
  );

  test('should get the current weather for the spots name', () async {
    // arrange
    when(mockSpotRepository.getCurrentWeatherForSpot(any))
        .thenAnswer((_) async => Right(tSpot));
    // act
    final result = await usecase(Params(spotName: tSpotName));
    // assert
    expect(result, Right(tSpot));
    verify(mockSpotRepository.getCurrentWeatherForSpot(tSpotName));
    verifyNoMoreInteractions(mockSpotRepository);
  });
}
