import 'package:azores_weather/weather/data/models/favourites_model.dart';
import 'package:azores_weather/weather/domain/entities/favourites.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tFavourites = FavouritesModel(list: ['spot1', 'spot2']);

  test(
    'should be a subclass of Favourites entity',
    () async {
      // assert
      expect(tFavourites, isA<Favourites>());
    },
  );
}
