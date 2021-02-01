import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const CLEAR_WEATHER = "Clear";
const RAIN_WEATHER = "Rain";
const CLOUDS_WEATHER = "Clouds";
const DRIZZLE_WEATHER = "Drizzle";
const THUNDERSTORM_WEATHER = "Thunderstorm";
const SNOW_WEATHER = "Snow";
const MIST_WEATHER = "Mist";
const FOG_WEATHER = "Fog";

class WeatherPrevWidget extends StatelessWidget {
  final Spot spot;

  const WeatherPrevWidget({Key key, @required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Card(
          elevation: 2.5,
          child: Row(children: <Widget>[
            Expanded(
              child: ListTile(
                  contentPadding: EdgeInsets.all(7),
                  title: Text(
                    spot.name,
                    style: TextStyle(fontSize: 30),
                  ),
                  trailing: weatherIcon(spot.weather)),
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: Text(
                spot.currentTemperature.toString() + "º",
                style: TextStyle(fontSize: 25),
              ),
            )
          ])),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Favourite',
          color: Colors.amber,
          icon: Icons.favorite_border,
          onTap: () => addToFavourites(context),
        )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => removeFromFavourites(context),
        ),
      ],
    );
  }

  Icon weatherIcon(String weather) {
    switch (weather) {
      case THUNDERSTORM_WEATHER:
        return Icon(
          Ionicons.md_thunderstorm,
          color: Colors.grey,
        );
      case RAIN_WEATHER:
        return Icon(Ionicons.md_rainy, color: Colors.grey);
      case CLOUDS_WEATHER:
        return Icon(Ionicons.md_cloud, color: Colors.grey);
      case DRIZZLE_WEATHER:
        return Icon(Feather.cloud_drizzle, color: Colors.grey);
      case MIST_WEATHER:
        return Icon(MaterialCommunityIcons.weather_hazy, color: Colors.grey);
      case FOG_WEATHER:
        return Icon(MaterialCommunityIcons.weather_hazy, color: Colors.grey);
      case CLEAR_WEATHER:
        return Icon(
          Icons.wb_sunny,
          color: Colors.amber,
        );
      default:
        return Icon(Icons.error, color: Colors.red);
    }
  }

  void addToFavourites(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(AddFavourite(this.spot.name));
  }

  removeFromFavourites(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(RemoveFavourite(this.spot.name));
  }
}
