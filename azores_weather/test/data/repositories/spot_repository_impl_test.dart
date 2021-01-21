import 'package:azores_weather/core/network/network_info.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_local_data_source.dart';
import 'package:azores_weather/features/weather/data/datasources/spot_remote_data_source.dart';
import 'package:azores_weather/features/weather/data/repositories/spot_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements SpotRemoteDataSource {}

class MockLocalDataSource extends Mock implements SpotLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SpotRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SpotRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
