import 'dart:io';

String constant(String name) {
  var dir = Directory.current.path;
  print(dir.toString());
  if (dir.endsWith('/lib')) {
    dir = dir.replaceAll('/lib', '');
  }
  return File('$dir/lib/core/constants/$name').readAsStringSync();
}
