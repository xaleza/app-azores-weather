import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SpotPage extends StatelessWidget {
  final Spot spot;

  const SpotPage({Key key, this.spot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            spot.name,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.star_outline),
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(alignment: Alignment.topCenter, child: getSpotImage()),
              Positioned(
                bottom: 10,
                right: 250,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thermostat_rounded,
                            size: 40,
                          ),
                          Text(
                            spot.currentTemperature.toString() + "º",
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Expanded(
            child: GridView.count(
                padding: EdgeInsets.all(10),
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 2,
                // Generate 100 Widgets that display their index in the List
                children: <Widget>[
                  Container(
                    //alignment: Alignment.topLeft,
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                              child: weatherIcon(spot.weather), scale: 1.7),
                          Text(
                            spot.weather,
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //alignment: Alignment.topRight,
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.device_thermostat,
                                size: 45,
                                color: Colors.blue,
                              ),
                              Text(
                                spot.minTemperature.toString() +
                                    "º/" +
                                    spot.maxTemperature.toString() +
                                    "º",
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ],
                          ),
                          Text(
                            "Temperatura",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //alignment: Alignment.topRight,
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                MaterialCommunityIcons.water_percent,
                                color: Colors.blue.shade300,
                                size: 50,
                              ),
                              Text(
                                spot.humidity.toString() + "%",
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ],
                          ),
                          Text(
                            "Humidade",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //alignment: Alignment.topRight,
                    width: 120,
                    height: 120,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.md_speedometer,
                                color: Colors.grey,
                                size: 40,
                              ),
                              Text(
                                spot.pressure.toString() + "hPa",
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ],
                          ),
                          Text(
                            "Pressão",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
  }

  Image getSpotImage() {
    var spotName = spot.name;
    return Image.asset(
      "assets/$spotName.jpg",
      height: 260,
    );
  }
}
