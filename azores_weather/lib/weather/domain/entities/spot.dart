import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Spot extends Equatable {
  final String name;
  final int currentTemperature;
  final String weather;

  Spot(
      {@required this.name,
      @required this.currentTemperature,
      @required this.weather});

  @override
  List<Object> get props => [name, currentTemperature, weather];
}
