import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: BlocProvider.of<WeatherBloc>(context).currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue.shade800,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (index) {
        BlocProvider.of<WeatherBloc>(context).add(PageTapped(index: index));
      },
      items: [
        BottomNavigationBarItem(
          label: 'Favoritos',
          icon: Icon(Icons.star),
        ),
        BottomNavigationBarItem(
          label: 'Locais Próximos',
          icon: Icon(Icons.pin_drop_sharp),
        ),
        BottomNavigationBarItem(
          label: 'Todos',
          icon: Icon(Icons.map_outlined),
        ),
      ],
    );
  }
}
