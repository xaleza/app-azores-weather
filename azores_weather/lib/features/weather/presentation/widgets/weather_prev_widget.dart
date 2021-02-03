import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/pages/spot_page.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                trailing: weatherIcon(spot.weather),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpotPage(spot: spot)),
                  );
                },
              ),
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

  void addToFavourites(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(AddFavourite(this.spot.name));
  }

  removeFromFavourites(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(RemoveFavourite(this.spot.name));
  }
}
