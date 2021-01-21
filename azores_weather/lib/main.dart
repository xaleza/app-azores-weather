import 'package:azores_weather/features/weather/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          accentColor: Colors.blue.shade600),
      home: WeatherPage(),
    );
  }
}
