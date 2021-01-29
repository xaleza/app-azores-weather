part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends WeatherState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});
  @override
  List<Object> get props => [currentIndex];
  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends WeatherState {
  @override
  String toString() => 'PageLoading';
}

class FavouritesPageLoaded extends WeatherState {
  final List<Spot> spots;

  FavouritesPageLoaded({@required this.spots});

  @override
  List<Object> get props => [spots];
  @override
  String toString() => 'FavouritesPageLoaded';
}

class NearMePageLoaded extends WeatherState {
  final List<Spot> spots;

  NearMePageLoaded({@required this.spots});

  @override
  List<Object> get props => [spots];
  @override
  String toString() => 'NearMePageLoaded';
}

class AllPageLoaded extends WeatherState {
  final List<Spot> spots;

  AllPageLoaded({@required this.spots});

  @override
  List<Object> get props => [spots];
  @override
  String toString() => 'AllPageLoaded';
}

class PageLoadingError extends WeatherState {
  final String message;

  PageLoadingError({@required this.message});

  @override
  List<Object> get props => [message];
  @override
  String toString() => 'PageLoadingError';
}