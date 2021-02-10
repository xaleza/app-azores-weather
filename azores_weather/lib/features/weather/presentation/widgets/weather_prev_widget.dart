import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/pages/spot_page.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPrevWidget extends StatelessWidget {
  final Spot spot;
  final isFavourite;

  const WeatherPrevWidget({Key key, @required this.spot, this.isFavourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.5,
        child: Row(children: <Widget>[
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(7),
              title: Text(
                spot.name,
                style: TextStyle(fontSize: 30),
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SpotPage(
                            spot: spot,
                            startsFavourite: this.isFavourite,
                          )),
                );
                BlocProvider.of<WeatherBloc>(context).add(RefreshPage());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: weatherIcon(spot.weather),
          ),
          Padding(
            padding: EdgeInsets.all(7),
            child: Text(
              spot.currentTemperature.toString() + "º",
              style: TextStyle(fontSize: 25),
            ),
          )
        ]));
  }
}
