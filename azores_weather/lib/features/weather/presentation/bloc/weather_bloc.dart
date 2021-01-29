import 'dart:async';

import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/features/weather/domain/entities/spot.dart';
import 'package:azores_weather/features/weather/domain/usecases/get_current_weather_for_spot.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const FAVOURITES_PAGE = 0;
const NEAR_ME_PAGE = 1;
const ALL_PAGE = 2;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherForSpot getCurrentWeatherForSpot;
  final AddSpotToFavourites addSpotToFavourite;
  final RemoveSpotFromFavourites removeSpotFromFavourites;
  final GetFavourites getFavourites;
  int currentIndex = 0;
  final favourites = ["Ponta Delgada", "Ribeira Grande", "Furnas"];
  final nearMeSpotList = ["Ponta Delgada", "Ribeira Grande", "Furnas"];
  final allSpots = ["Ponta Delgada", "Ribeira Grande", "Furnas"];

  WeatherBloc(
      {@required weather,
      @required addFavourite,
      @required removeFavourite,
      @required getFavs})
      : assert(weather != null),
        assert(addFavourite != null),
        assert(removeFavourite != null),
        assert(getFavs != null),
        getCurrentWeatherForSpot = weather,
        addSpotToFavourite = addFavourite,
        removeSpotFromFavourites = removeFavourite,
        getFavourites = getFavs,
        super(PageLoading());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is AppStarted) {
      //await buildFavourites();

      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();
      print("Pageloading");

      if (this.currentIndex == FAVOURITES_PAGE) {
        final spotsEither = await getWeatherForSpots(favourites);
        yield* spotsEither.fold((failure) async* {
          yield PageLoadingError(message: _mapFailureToMessage(failure));
        }, (spots) async* {
          yield FavouritesPageLoaded(spots: spots);
          print("FavouritesPageLoaded");
        });
      }
      if (this.currentIndex == NEAR_ME_PAGE) {
        final spotsEither = await getWeatherForSpots(this.nearMeSpotList);
        yield* spotsEither.fold((failure) async* {
          yield PageLoadingError(message: _mapFailureToMessage(failure));
        }, (spots) async* {
          yield NearMePageLoaded(spots: spots);
        });
      }
      if (this.currentIndex == ALL_PAGE) {
        final spotsEither = await getWeatherForSpots(this.allSpots);
        yield* spotsEither.fold((failure) async* {
          yield PageLoadingError(message: _mapFailureToMessage(failure));
        }, (spots) async* {
          yield AllPageLoaded(spots: spots);
        });
      }
    }
    if (event is AddFavourite) {
      addFavourite(event.spotName);
    }
    if (event is RemoveFavourite) {
      removeFavourite(event.spotName);
    }
  }

  /* Future buildFavourites() async {
    final getFavourites = await this.getFavourites(NoParams());
    getFavourites.fold((failure) => favourites = Favourites(list: []),
        (success) => favourites = success);
  } */

  Future<Either<Failure, List<Spot>>> getWeatherForSpots(
      List<String> spotList) async {
    var spots = List<Spot>();
    var fail;
    for (String favourite in spotList) {
      var spot = await this
          .getCurrentWeatherForSpot(ParamsWeather(spotName: favourite));
      spot.fold((failure) => fail = Left(failure), (spot) => spots.add(spot));
      if (spot.isLeft()) {
        return Left(fail);
      }
    }
    return Right(spots);
  }

  void addFavourite(String spotName) {}
  void removeFavourite(String spotName) {}

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
