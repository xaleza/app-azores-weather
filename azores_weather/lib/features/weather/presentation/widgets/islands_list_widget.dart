import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IslandsListWidget extends StatelessWidget {
  const IslandsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/saomiguelprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "São Miguel",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "São Miguel"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/santamariaprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Santa Maria",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Santa Maria"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/terceiraprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Terceira",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Terceira"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/saojorgeprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "São Jorge",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "São Jorge"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/picoprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Pico",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Pico"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/faialprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Faial",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Faial"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/graciosaprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Graciosa",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Graciosa"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/floresprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Flores",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Flores"),
      )),
      Card(
          child: ListTile(
        leading: SizedBox(
            height: 60.0,
            width: 60.0, // fixed width and height
            child: Image.asset(
              "assets/islands_prev/corvoprev.jpg",
            )),
        contentPadding: EdgeInsets.all(7),
        title: Text(
          "Corvo",
          style: TextStyle(fontSize: 27),
        ),
        onTap: () => getWeatherForIsland(context, "Corvo"),
      )),
    ]);
  }

  getWeatherForIsland(BuildContext context, String name) {
    BlocProvider.of<WeatherBloc>(context).add(IslandTapped(name));
  }
}
