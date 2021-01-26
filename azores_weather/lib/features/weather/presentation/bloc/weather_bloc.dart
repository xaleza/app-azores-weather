import 'dart:async';

import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherForSpot getCurrentWeatherForSpot;
  final AddSpotToFavourites addSpotToFavourite;
  final RemoveSpotFromFavourites removeSpotFromFavourites;
  final GetFavourites getFavourites;

  WeatherBloc(
      {@required weather,
      @required addFavourite,
      @required removeFavourite,
      @required getFavs})
      : assert(weather != null),
        assert(addFavourite != null),
        assert(removeFavourite != null),
        assert(getFavs != null),
        getCurrentWeatherForSpot = weather,
        addSpotToFavourite = addFavourite,
        removeSpotFromFavourites = removeFavourite,
        getFavourites = getFavs,
        super(Empty());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
