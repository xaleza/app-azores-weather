import 'package:azores_weather/core/error/exception.dart';
import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/network/network_info.dart';
import 'package:azores_weather/core/utils/city_ids_translator.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_local_data_source.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_remote_data_source.dart';
import 'package:azores_weather/features/weather/data/models/spot_model.dart';
import 'package:azores_weather/features/weather/data/repositories/spot_repository_impl.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements SpotRemoteDataSource {}

class MockLocalDataSource extends Mock implements SpotLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockCityIdsTranslator extends Mock implements CityIdsTranslator {}

void main() {
  SpotRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  MockCityIdsTranslator mockCityIdsTranslator;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockCityIdsTranslator = MockCityIdsTranslator();
    repository = SpotRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
        translator: mockCityIdsTranslator);
  });

  // DATA FOR THE MOCKS AND ASSERTIONS
  // We'll use these three variables throughout all the tests
  final tSpotName = "Ponta Delgada";
  final tSpotId = 3372783;
  final tSpotModel = SpotModel(
      name: tSpotName,
      currentTemperature: 15,
      humidity: 100,
      maxTemperature: 20,
      minTemperature: 10,
      pressure: 100,
      weather: "Sunny");
  final Spot tSpot = tSpotModel;

  test('should check if the device is online', () {
    //arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    repository.getCurrentWeatherForSpot(tSpotName);
    // assert
    verify(mockNetworkInfo.isConnected);
  });

  group('device is online', () {
    // This setUp applies only to the 'device is online' group
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockCityIdsTranslator.translate(tSpotName))
          .thenAnswer((_) async => tSpotId);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId))
          .thenAnswer((_) async => tSpotModel);
      // act
      final result = await repository.getCurrentWeatherForSpot(tSpotName);
      // assert
      verify(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId));
      expect(result, equals(Right(tSpot)));
    });

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId))
            .thenAnswer((_) async => tSpotModel);
        // act
        await repository.getCurrentWeatherForSpot(tSpotName);
        // assert
        verify(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId));
        verify(mockLocalDataSource.cacheSpotWeather(tSpot));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCurrentWeatherForSpot(tSpotName);
        // assert
        verify(mockRemoteDataSource.getFreshWeatherForSpot(tSpotId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockCityIdsTranslator.translate(tSpotName))
          .thenAnswer((_) async => tSpotId);
    });

    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockLocalDataSource.getCachedSpotWeather(tSpotName))
            .thenAnswer((_) async => tSpotModel);
        // act
        final result = await repository.getCurrentWeatherForSpot(tSpotName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedSpotWeather(tSpotName));
        expect(result, equals(Right(tSpot)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        // arrange
        when(mockLocalDataSource.getCachedSpotWeather(tSpotName))
            .thenThrow(CacheException());
        // act
        final result = await repository.getCurrentWeatherForSpot(tSpotName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedSpotWeather(tSpotName));
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });
}
