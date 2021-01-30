import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/widgets/bottom_nav_bar.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_prev_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<WeatherBloc>()..add(AppStarted()),
        child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.menu),
              centerTitle: true,
              title: Text('Tempo nos Açores'),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.search),
                ),
              ],
            ),
            body: buildBody(),
            bottomNavigationBar: buildBottomNavBar()));
  }

  BlocBuilder<WeatherBloc, WeatherState> buildBody() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is PageLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FavouritesPageLoaded) {
        return ListView.builder(
            itemCount: state.spots.length,
            itemBuilder: (BuildContext context, int index) {
              return WeatherPrevWidget(spot: state.spots[index]);
            });
      }
      if (state is AllPageLoaded) {
        return ListView.builder(
            itemCount: state.spots.length,
            itemBuilder: (BuildContext context, int index) {
              return WeatherPrevWidget(spot: state.spots[index]);
            });
      }
      if (state is PageLoadingError) {
        return Center(
          child: Text('failed to fetch posts'),
        );
      } else {
        return Center(
          child: Text('failed to fetch posts'),
        );
      }
    });
  }

  BlocBuilder<WeatherBloc, WeatherState> buildBottomNavBar() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return BottomNavBar();
    });
  }
}
