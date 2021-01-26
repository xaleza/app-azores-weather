part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForFavouritesEvent extends WeatherEvent {}

class GetWeatherForNearSpotsEvent extends WeatherEvent {}

class GetWeatherForAllSpotsEvent extends WeatherEvent {}

class AddSpotToFavouriteEvent extends WeatherEvent {
  final String spotName;

  AddSpotToFavouriteEvent(this.spotName);

  @override
  List<Object> get props => [spotName];
}

class RemoveSpotFromFavouritesEvent extends WeatherEvent {
  final String spotName;

  RemoveSpotFromFavouritesEvent(this.spotName);

  @override
  List<Object> get props => [spotName];
}
