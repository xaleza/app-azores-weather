import 'dart:convert';

import 'package:azores_weather/core/constants/constant_reader.dart';
import 'package:azores_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  final initialSpots;

  const SearchPage({Key key, this.initialSpots}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List();

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            BlocProvider.of<WeatherBloc>(context).add(PageTapped(index: 0));
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: TextField(
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            prefixIcon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Procurar...',
          ),
        ),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: new ListTile(
            title: Text(
              filteredNames[index],
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              BlocProvider.of<WeatherBloc>(context)
                  .add(SearchedSpotTapped(spotName: filteredNames[index]));
            },
          ),
        );
      },
    );
  }

  void _getNames() async {
    final Map<String, dynamic> response =
        await json.decode(await constant('assets/city_ids.json'));
    var keys = response.keys;
    List tempList = new List<String>();
    keys.forEach((key) {
      tempList.add(key);
    });

    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
