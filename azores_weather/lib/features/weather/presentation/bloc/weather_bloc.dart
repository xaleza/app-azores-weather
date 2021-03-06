import 'dart:async';

import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/usecases/add_spot_to_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/get_favourites.dart';
import 'package:azores_weather/core/favourites/domain/usecases/remove_spot_from_favourites.dart';
import 'package:azores_weather/core/location/location_info.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:azores_weather/core/utils/spot_list_for_island.dart';
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

  var favouritesList;
  var nearMeSpotList = List<String>();
  final List<String> searchInitialList = ["Ponta Delgada", "Furnas"];
  //final nearMeSpotList = ["Ponta Delgada", "Ribeira Grande", "Furnas"];
  //final allSpots = ["Ponta Delgada", "Ribeira Grande", "Furnas"];

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
      await buildFavouritesList();
      await buildNearestSpotsList();
      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == FAVOURITES_PAGE) {
        yield* _buildFavouritesPage();
      }
      if (this.currentIndex == NEAR_ME_PAGE) {
        yield* _buildNearMePage();
      }
      if (this.currentIndex == ALL_PAGE) {
        yield AllPageSelected();
      }
    }
    if (event is AddFavourite) {
      _addFavourite(event);
    }
    if (event is RemoveFavourite) {
      yield* _removeFavourite(event);
    }
    if (event is IslandTapped) {
      yield PageLoading();
      yield* _buildIslandPage(event.islandName);
    }
    if (event is RefreshPage) {
      print("RefreshPage");
      yield PageLoading();
      if (this.currentIndex == FAVOURITES_PAGE) {
        yield* _buildFavouritesPage();
      }
      if (this.currentIndex == NEAR_ME_PAGE) {
        yield* _buildNearMePage();
      }
      if (this.currentIndex == ALL_PAGE) {
        yield AllPageSelected();
      }
    }
    if (event is SearchTapped) {
      yield SearchPageInitial(initialSpots: searchInitialList);
    }
    if (event is SearchedSpotTapped) {
      yield* _buildSpotPage(event);
    }
  }

  Stream<WeatherState> _buildSpotPage(SearchedSpotTapped event) async* {
    var spotEither = await this
        .getCurrentWeatherForSpot(ParamsWeather(spotName: event.spotName));
    yield* spotEither.fold((failure) async* {
      yield PageLoadingError(message: _mapFailureToMessage(failure));
    }, (spot) async* {
      yield SpotPageLoaded(spot: spot);
    });
  }

  void _addFavourite(AddFavourite event) {
    favouritesList.add(event.spotName);
    this.addSpotToFavourite(FavouritesParams(spotName: event.spotName));
  }

  Stream<WeatherState> _removeFavourite(RemoveFavourite event) async* {
    favouritesList.remove(event.spotName);
    this.removeSpotFromFavourites(Params(spotName: event.spotName));
  }

  Stream<WeatherState> _buildNearMePage() async* {
    if (nearMeSpotList.isEmpty) {
      yield NearMePageEmpty();
    } else {
      final spotsEither = await getWeatherForSpotList(this.nearMeSpotList);
      yield* spotsEither.fold((failure) async* {
        yield PageLoadingError(message: _mapFailureToMessage(failure));
      }, (spots) async* {
        yield NearMePageLoaded(spots: spots);
      });
    }
  }

  Stream<WeatherState> _buildFavouritesPage() async* {
    if (favouritesList.isEmpty) {
      yield FavouritesPageEmpty();
    } else {
      final spotsEither = await getWeatherForSpotList(favouritesList);
      yield* spotsEither.fold((failure) async* {
        yield PageLoadingError(message: _mapFailureToMessage(failure));
      }, (spots) async* {
        yield FavouritesPageLoaded(spots: spots);
        print("FavouritesPageLoaded");
      });
    }
  }

  Future buildFavouritesList() async {
    final getFavourites = await this.getFavourites(NoParams());
    getFavourites.fold((failure) => favouritesList = [],
        (success) => favouritesList = success.list);
  }

  Future buildNearestSpotsList() async {
    this.nearMeSpotList = await getNearestSpots();
  }

  Future<Either<Failure, List<Spot>>> getWeatherForSpotList(
      List spotList) async {
    var spots = List<Spot>();
    var fail;
    for (String favourite in spotList) {
      var spot = await this
          .getCurrentWeatherForSpot(ParamsWeather(spotName: favourite));
      spot.fold((failure) => fail = failure, (spot) => spots.add(spot));
      if (spot.isLeft()) {
        return Left(fail);
      }
    }
    return Right(spots);
  }

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

  Stream<WeatherState> _buildIslandPage(String islandName) async* {
    var spotList = await spotListForIsland(islandName);
    final spotsEither = await getWeatherForSpotList(spotList);
    yield* spotsEither.fold((failure) async* {
      yield PageLoadingError(message: _mapFailureToMessage(failure));
    }, (spots) async* {
      yield IslandPageLoaded(islandName: islandName, spots: spots);
      print("IslandPageLoaded");
    });
  }

  bool isFavourite(String spotName) {
    return favouritesList.contains(spotName);
  }
}
