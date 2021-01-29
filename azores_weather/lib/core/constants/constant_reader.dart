import 'dart:io';

import 'package:flutter/services.dart';

Future<String> constant() async {
  return await rootBundle.loadString('assets/city_ids.json');
}
