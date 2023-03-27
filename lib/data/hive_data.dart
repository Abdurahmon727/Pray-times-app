import 'package:hive_flutter/hive_flutter.dart';

void putData(String varName, dynamic value) async {
  var localFile = await Hive.openBox('myBox');
  localFile.put(varName, value);
}

Future<dynamic> getData(String varName) async {
  var localFile = await Hive.openBox('myBox');
  String data = localFile.get(varName);

  return data;
}
