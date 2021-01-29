import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/core/utils/city_ids_translator.dart';
import 'package:azores_weather/features/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/favourites/data/datasources/favourites_local_data_source.dart';
import 'core/favourites/data/repositories/favourites_repository_impl.dart';
import 'core/favourites/domain/repositories/favourites_repository.dart';
import 'core/network/network_info.dart';
import 'features/weather/data/datasources/spot_local_data_source.dart';
import 'features/weather/data/datasources/spot_remote_data_source.dart';
import 'features/weather/data/repositories/spot_repository_impl.dart';
import 'features/weather/domain/repositories/spot_repository.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather
  sl.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      addFavourite: sl<AddSpotToFavourites>(),
      removeFavourite: sl<RemoveSpotFromFavourites>(),
      weather: sl<GetCurrentWeatherForSpot>(),
      getFavs: sl<GetFavourites>(),
    ),
  );
  // Use cases
  sl.registerLazySingleton<GetCurrentWeatherForSpot>(
      () => GetCurrentWeatherForSpot(sl()));
  sl.registerLazySingleton(() => AddSpotToFavourites(sl()));
  sl.registerLazySingleton(() => RemoveSpotFromFavourites(sl()));
  sl.registerLazySingleton(() => GetFavourites(sl()));

  // Repositories
  sl.registerLazySingleton<SpotRepository>(
    () => SpotRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      translator: sl<CityIdsTranslator>(),
    ),
  );

  sl.registerLazySingleton<FavouritesRepository>(
    () => FavouritesRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SpotRemoteDataSource>(
    () => SpotRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<SpotLocalDataSource>(
    () => SpotLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<FavouritesLocalDataSource>(
    () => FavouritesLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<CityIdsTranslator>(
    () => CityIdsTranslatorImpl(),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
