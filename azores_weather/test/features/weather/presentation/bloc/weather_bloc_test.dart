import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';

class MockGetCurrentWeatherForSpot extends Mock
    implements GetCurrentWeatherForSpot {}

class MockAddSpotToFavourite extends Mock implements AddSpotToFavourites {}

class MockRemoveSpotFromFavourites extends Mock
    implements RemoveSpotFromFavourites {}

class MockGetFavourites extends Mock implements GetFavourites {}

void main() {
  WeatherBloc bloc;
  MockGetCurrentWeatherForSpot mockGetCurrentWeatherForSpot;
  MockAddSpotToFavourite mockAddSpotToFavourite;
  MockRemoveSpotFromFavourites mockRemoveSpotFromFavourites;
  MockGetFavourites mockGetFavourites;

  setUp(() {
    mockGetCurrentWeatherForSpot = MockGetCurrentWeatherForSpot();
    mockAddSpotToFavourite = MockAddSpotToFavourite();
    mockRemoveSpotFromFavourites = MockRemoveSpotFromFavourites();
    mockGetFavourites = MockGetFavourites();
    bloc = WeatherBloc(
        weather: mockGetCurrentWeatherForSpot,
        addFavourite: mockAddSpotToFavourite,
        removeFavourite: mockRemoveSpotFromFavourites,
        getFavs: mockGetFavourites);
  });

  test('initial state should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetWeatherForFavouritesEvent', () {
    final Favourites favourites =
        Favourites(list: ["Ponta Delgada", "Ribeira Grande"]);
    final Spot tSpot1 = Spot(
        name: "Ponta Delgada",
        currentTemperature: null,
        minTemperature: null,
        maxTemperature: null,
        weather: null,
        pressure: null,
        humidity: null);
    final Spot tSpot2 = Spot(
        name: "Ribeira Grande",
        currentTemperature: null,
        minTemperature: null,
        maxTemperature: null,
        weather: null,
        pressure: null,
        humidity: null);
    final List<Spot> favouriteSpots = [tSpot1, tSpot2];
  });
}
