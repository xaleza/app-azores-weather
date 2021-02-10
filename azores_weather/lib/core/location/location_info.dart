import 'dart:convert';

import 'package:azores_weather/core/constants/constant_reader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

Future<List<String>> getNearestSpots() async {
  var position = await _determinePosition();
  var nearSpotList = List<String>();
  Distance distance = new Distance();

  final Map<String, dynamic> jsonMap =
      await json.decode(await constant('assets/city_ids.json'));

  jsonMap.forEach((spot, spotInfo) {
    var km = distance.as(
        LengthUnit.Kilometer,
        new LatLng(position.latitude, position.longitude),
        new LatLng(spotInfo["lat"], spotInfo["long"]));
    if (km < 50) {
      nearSpotList.add(spot);
    }
  });
  return nearSpotList;
}
