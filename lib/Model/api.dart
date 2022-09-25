import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:namoz_vaqtlari/Model/regions.dart';

Future<void> getTimes(String place, BuildContext context) async {
  http.Response response = await http
      .get(Uri.parse('https://islomapi.uz/api/present/day?region=$place'));
  if (response.statusCode == 200) {
    currentDate = jsonDecode(response.body)['date'];
    currentDay = jsonDecode(response.body)['weekday'];
    currentPlace = jsonDecode(response.body)['region'];
    currentNamozTimes[0] = jsonDecode(response.body)['times']['tong_saharlik'];
    currentNamozTimes[1] = jsonDecode(response.body)['times']['quyosh'];
    currentNamozTimes[2] = jsonDecode(response.body)['times']['peshin'];
    currentNamozTimes[3] = jsonDecode(response.body)['times']['asr'];
    currentNamozTimes[4] = jsonDecode(response.body)['times']['shom_iftor'];
    currentNamozTimes[5] = jsonDecode(response.body)['times']['hufton'];
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to connect with Server, Oops :(')));
  }
}
