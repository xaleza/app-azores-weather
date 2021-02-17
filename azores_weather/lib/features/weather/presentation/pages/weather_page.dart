import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:azores_weather/features/weather/presentation/pages/about_page.dart';
import 'package:azores_weather/features/weather/presentation/pages/island_page.dart';
import 'package:azores_weather/features/weather/presentation/pages/search_page.dart';
import 'package:azores_weather/features/weather/presentation/pages/spot_page.dart';
import 'package:azores_weather/features/weather/presentation/widgets/bottom_nav_bar.dart';
import 'package:azores_weather/features/weather/presentation/widgets/islands_list_widget.dart';
import 'package:azores_weather/features/weather/presentation/widgets/weather_prev_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.menu),
          centerTitle: true,
          title: Text('Tempo nos Açores'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(SearchTapped());
                },
              ),
            ),
          ],
        ),
        body: buildBody(),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Tempo nos Açores',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Sobre'),
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavBar());
  }

  BlocBuilder<WeatherBloc, WeatherState> buildBody() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is SearchPageInitial) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPage(initialSpots: state.initialSpots)));
        });
        return Center(child: CircularProgressIndicator());
      }
      if (state is PageLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FavouritesPageEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Ainda não tem favoritos. Selecione um local e carregue na ⭐ para adcionar aos favoritos!',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
            ),
          ),
        );
      }
      if (state is FavouritesPageLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            return BlocProvider.of<WeatherBloc>(context).add(RefreshPage());
          },
          child: ListView.builder(
              itemCount: state.spots.length,
              itemBuilder: (BuildContext context, int index) {
                return WeatherPrevWidget(
                  spot: state.spots[index],
                  isFavourite: true,
                );
              }),
        );
      }
      if (state is NearMePageEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Parece que está longe dos Açores 😢',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
            ),
          ),
        );
      }
      if (state is NearMePageLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            return BlocProvider.of<WeatherBloc>(context).add(RefreshPage());
          },
          child: ListView.builder(
              itemCount: state.spots.length,
              itemBuilder: (BuildContext context, int index) {
                return WeatherPrevWidget(
                  spot: state.spots[index],
                  isFavourite: BlocProvider.of<WeatherBloc>(context)
                      .isFavourite(state.spots[index].name),
                );
              }),
        );
      }
      if (state is IslandPageLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IslandPage(
                        islandName: state.islandName,
                        spots: state.spots,
                      )));
        });
        return Center(child: CircularProgressIndicator());
      }
      if (state is AllPageSelected) {
        return IslandsListWidget();
      }
      if (state is SpotPageLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SpotPage(
                        spot: state.spot,
                        startsFavourite: BlocProvider.of<WeatherBloc>(context)
                            .isFavourite(state.spot.name),
                      )));
        });
        return Center(child: CircularProgressIndicator());
      }
      if (state is PageLoadingError) {
        return Center(
          child: Text('Ocorreu um erro'),
        );
      } else {
        return Center(
          child: Text('Ocorreu um erro'),
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
