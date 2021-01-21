import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Spot extends Equatable {
  final String name;
  final int currentTemperature;
  final int minTemperature;
  final int maxTemperature;
  final String weather;
  final int pressure;
  final int humidity;

  Spot(
      {@required this.name,
      @required this.currentTemperature,
      @required this.minTemperature,
      @required this.maxTemperature,
      @required this.weather,
      @required this.pressure,
      @required this.humidity});

  @override
  List<Object> get props => [name];
}
