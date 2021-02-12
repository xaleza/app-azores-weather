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

class FavouritesPageEmpty extends WeatherState {
  @override
  String toString() => 'FavouritesPageEmpty';
}

class NearMePageEmpty extends WeatherState {
  @override
  String toString() => 'NearMePageEmpty';
}

class NearMePageLoaded extends WeatherState {
  final List<Spot> spots;

  NearMePageLoaded({@required this.spots});

  @override
  List<Object> get props => [spots];
  @override
  String toString() => 'NearMePageLoaded';
}

class AllPageSelected extends WeatherState {}

class IslandPageLoaded extends WeatherState {
  final List<Spot> spots;
  final islandName;

  IslandPageLoaded({@required this.islandName, @required this.spots});

  @override
  List<Object> get props => [spots];
  @override
  String toString() => 'IslandPageLoaded';
}

class PageLoadingError extends WeatherState {
  final String message;

  PageLoadingError({@required this.message});

  @override
  List<Object> get props => [message];
  @override
  String toString() => 'PageLoadingError';
}

class SearchPageInitial extends WeatherState {
  final List<String> initialSpots;

  SearchPageInitial({@required this.initialSpots});

  @override
  List<Object> get props => [initialSpots];
  @override
  String toString() => 'SearchPageInitial';
}

class SpotPageLoaded extends WeatherState {
  final Spot spot;

  SpotPageLoaded({@required this.spot});

  @override
  List<Object> get props => [spot];
  @override
  String toString() => 'SpotPageLoaded';
}
