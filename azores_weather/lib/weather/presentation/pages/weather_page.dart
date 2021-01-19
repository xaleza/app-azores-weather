import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: ListView(
          children: const <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  'Lagoa',
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text('14º'),
                trailing: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Ribeira Grande',
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text('14º'),
                trailing: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Ponta Delgada',
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text('14º'),
                trailing: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Vila Franca do Campo',
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text('14º'),
                trailing: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue.shade800,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
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
        ));
  }
}
