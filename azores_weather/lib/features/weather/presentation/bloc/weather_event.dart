part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends WeatherEvent {}

class PageTapped extends WeatherEvent {
  final int index;

  PageTapped({@required this.index});
}

class AddFavourite extends WeatherEvent {
  final String spotName;

  AddFavourite(this.spotName);

  @override
  List<Object> get props => [spotName];
}

class RemoveFavourite extends WeatherEvent {
  final String spotName;

  RemoveFavourite(this.spotName);

  @override
  List<Object> get props => [spotName];
}
