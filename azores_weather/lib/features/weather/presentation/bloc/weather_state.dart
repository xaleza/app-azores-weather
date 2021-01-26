part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class Empty extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final List<Spot> spots;

  Loaded({@required this.spots});

  @override
  List<Object> get props => [spots];
}

class Error extends WeatherState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
