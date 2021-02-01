import 'package:flutter/services.dart';

Future<String> constant(String constant) async {
  return await rootBundle.loadString(constant);
}
