import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SpotPage extends StatefulWidget {
  final Spot spot;
  final startsFavourite;

  const SpotPage({Key key, this.spot, this.startsFavourite}) : super(key: key);

  @override
  _SpotPageState createState() => _SpotPageState();
}

class _SpotPageState extends State<SpotPage> {
  bool _isFavorited;

  @override
  void initState() {
    _isFavorited = widget.startsFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.spot.name,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon:
                    (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
                onPressed: () => _toggleFavorite(context),
              ),
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
                            widget.spot.currentTemperature.toString() + "º",
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

                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                crossAxisCount: 2,
                primary: false,
                padding: const EdgeInsets.all(1.5),
                childAspectRatio: 1,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Transform.scale(
                                child: weatherIcon(widget.spot.weather),
                                scale: 1.7),
                          ),
                          Text(
                            _translateWeatherInfo(widget.spot.weather),
                            style: TextStyle(fontSize: 25.0),
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
                                widget.spot.minTemperature.toString() +
                                    "º/" +
                                    widget.spot.maxTemperature.toString() +
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
                                widget.spot.humidity.toString() + "%",
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
                                widget.spot.pressure.toString() + "hPa",
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
    var spotName = widget.spot.name;
    return Image.asset(
      "assets/spots_prev/$spotName.jpg",
      height: 262,
    );
  }

  void _toggleFavorite(BuildContext context) {
    setState(() {
      if (_isFavorited) {
        _showConfirmationDialog(context);
      } else {
        BlocProvider.of<WeatherBloc>(context)
            .add(AddFavourite(widget.spot.name));
        _isFavorited = true;
      }
    });
  }

  String _translateWeatherInfo(String weather) {
    switch (weather) {
      case THUNDERSTORM_WEATHER:
        return "Trovoada";
      case RAIN_WEATHER:
        return "Aguaceiros";
      case CLOUDS_WEATHER:
        return "Nublado";
      case DRIZZLE_WEATHER:
        return "Chuviscos";
      case MIST_WEATHER:
        return "Neblina";
      case FOG_WEATHER:
        return "Nevoeiro";
      case CLEAR_WEATHER:
        return "Céu Limpo";
      default:
        return "Erro";
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    var spotName = widget.spot.name;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Remover dos favoritos"),
          content: new Text(
              "Tem a certeza que quer remover $spotName dos favouritos?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("NÃO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("SIM"),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context)
                    .add(RemoveFavourite(widget.spot.name));
                setState(() {
                  _isFavorited = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
