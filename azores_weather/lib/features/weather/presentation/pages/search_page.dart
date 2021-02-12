import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final initialSpots;

  const SearchPage({Key key, this.initialSpots}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(PageTapped(index: 0));
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: TextField(
            //controller: _filter,
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          ),
        ),
        body: ListView.builder(
            itemCount: initialSpots.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Text(initialSpots[index]),
              );
            }));
  }
}
