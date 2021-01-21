import 'package:azores_weather/core/utils/city_ids_translator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CityIdsTranslator translator;

  setUp(() {
    translator = CityIdsTranslatorImpl();
  });

  final tSpotName = "Ponta Delgada";
  final tSpotId = 3372783;

  test('should translate a name to a city id', () {
    // act
    final result = translator.translate(tSpotName);
    // assert
    expect(result, tSpotId);
  });
}
