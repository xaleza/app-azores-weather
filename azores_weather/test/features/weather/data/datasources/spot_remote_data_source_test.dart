import 'dart:convert';

import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_remote_data_source.dart';
import 'package:azores_weather/features/weather/data/models/spot_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  SpotRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SpotRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tSpotId = 3372783;

  test(
    'should preform a GET request on a URL with number being the endpoint and with application/json header',
    () {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('weather.json'), 200),
      );
      // act
      dataSource.getFreshWeatherForSpot(tSpotId);
      // assert
      verify(mockHttpClient.get(
        'http://api.openweathermap.org/data/2.5/weather?id=$tSpotId&appid=$API_KEY&units=metric',
        headers: {'Content-Type': 'application/json'},
      ));
    },
  );

  final tSpotModel = SpotModel.fromJson(json.decode(fixture('weather.json')));

  test(
    'should return Spot when the response code is 200 (success)',
    () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('weather.json'), 200),
      );
      // act
      final result = await dataSource.getFreshWeatherForSpot(tSpotId);
      // assert
      expect(result, equals(tSpotModel));
    },
  );

  test(
    'should throw a ServerException when the response code is 404 or other',
    () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );
      // act
      final call = dataSource.getFreshWeatherForSpot;
      // assert
      expect(() => call(tSpotId), throwsA(isA<ServerException>()));
    },
  );
}
