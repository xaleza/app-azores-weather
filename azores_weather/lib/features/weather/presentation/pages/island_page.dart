import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_prev_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IslandPage extends StatelessWidget {
  final islandName;
  final spots;

  const IslandPage({Key key, this.islandName, this.spots}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<WeatherBloc>(context).add(PageTapped(index: 2));
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            this.islandName,
          ),
        ),
        body: ListView.builder(
            itemCount: spots.length,
            itemBuilder: (BuildContext context, int index) {
              return WeatherPrevWidget(
                spot: spots[index],
                isFavourite: BlocProvider.of<WeatherBloc>(context)
                    .isFavourite(spots[index].name),
              );
            }));
  }
}
