import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetWeatherForSpot extends Mock implements GetCurrentWeatherForSpot {}

class MockAddSpotToFavourites extends Mock implements AddSpotToFavourites {}

class MockRemoveSpotFromFavourites extends Mock
    implements RemoveSpotFromFavourites {}

class MockGetFavourties extends Mock implements GetFavourites {}

void main() {
  WeatherBloc bloc;
  MockGetWeatherForSpot mockGetWeatherForSpot;
  MockAddSpotToFavourites mockAddSpotToFavourites;
  MockRemoveSpotFromFavourites mockRemoveSpotFromFavourites;
  MockGetFavourties mockGetFavourties;

  setUp(() {
    mockGetWeatherForSpot = MockGetWeatherForSpot();
    mockAddSpotToFavourites = MockAddSpotToFavourites();
    mockRemoveSpotFromFavourites = MockRemoveSpotFromFavourites();
    mockGetFavourties = MockGetFavourties();

    bloc = WeatherBloc(
        weather: mockGetWeatherForSpot,
        addFavourite: mockAddSpotToFavourites,
        removeFavourite: mockRemoveSpotFromFavourites,
        getFavs: mockGetFavourties);
  });

  test('initial state should be PageLoading', () {
    // assert
    expect(bloc.state, equals(PageLoading()));
  });

  group('GetWeatherForSpot', () {
    final tSpotName = 'Ponta Delgada';
    final tSpot = Spot(
        name: 'Ponta Delgada',
        currentTemperature: null,
        minTemperature: null,
        maxTemperature: null,
        weather: null,
        pressure: null,
        humidity: null);
    /* test('should get data from concrete use case', () async {
      // arrange
      when(mockGetWeatherForSpot(any)).thenAnswer((_) async => Right(tSpot));
      // act
      bloc.add(PageTapped(index: 1));
      await untilCalled(mockGetWeatherForSpot(any));
      // assert
      verify(mockGetWeatherForSpot(ParamsWeather(spotName: tSpotName)));
    }); */
  });
}
