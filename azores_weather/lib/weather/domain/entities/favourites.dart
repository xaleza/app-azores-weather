import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Favourite Spots
class Favourites extends Equatable {
  final List<String> list;

  Favourites({@required this.list});

  @override
  List<Object> get props => [list];
}
