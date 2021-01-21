import 'package:azores_weather/core/error/failures.dart';
import 'package:azores_weather/core/favourites/domain/entities/favourites.dart';
import 'package:azores_weather/core/favourites/domain/repositories/favourites_repository.dart';
import 'package:azores_weather/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetFavourites extends UseCase<Favourites, NoParams> {
  final FavouritesRepository repository;

  GetFavourites(this.repository);

  Future<Either<Failure, Favourites>> call(NoParams params) async {
    return await repository.getFavourites();
  }
}
