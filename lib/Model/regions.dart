import 'package:flutter/material.dart';

late double currentFontSize;
late int currentRegion;
late String currentDistict;

String currentDate = '';
String currentDay = '';
String currentPlace = '';
List<String> currentNamozTimes = ['', '', '', '', '', ''];
late List<bool> isNotificationEnabled;

late bool isSystemMode;

enum Language { uzbek, kril, ruskiy }

Language currentLanguage = Language.uzbek;

List<String> regions = [
  'Toshkent',
  'Samarqand',
  'Farg\'оna',
  'Andijon',
  'Namangan',
  'Jizzax',
  'Buxoro',
  'Qashqadaryo',
  'Surxondaryo',
  'Navoiy',
  'Qoraqalpog\'iston',
  'Sirdaryo',
  'Xorazm',
];

void makeDropdowns(List<String> a, List<DropdownMenuItem<int>> b) {
  for (int i = 0; i < regions.length; i++) {
    var k = DropdownMenuItem<int>(
      value: i,
      child: Text(a[i]),
    );
    b.add(k);
  }
}

void makeDropdowns2(
    List<List<String>> a, List<List<DropdownMenuItem<String>>> b) {
  for (int j = 0; j < regions.length; j++) {
    List<DropdownMenuItem<String>> it = [];
    for (int i = 0; i < disticts[j].length; i++) {
      var k = DropdownMenuItem<String>(
        value: a[j][i],
        child: Text(a[j][i]),
      );
      it.add(k);
    }
    b.add(it);
  }
}

List<DropdownMenuItem<int>> regionsItem = [];
List<List<DropdownMenuItem<String>>> distictItem = [];

List<List<String>> disticts = [
  ['Angren', 'Burchmulla', 'Uchtepa', 'Yangibоzоr', 'Toshkent'],
  ['Kattaqo\'rg\'оn', 'Urgut', 'Samarqand', 'Jomboy'],
  ['Marg\'ilon', 'Quva', 'Qo\'qon', 'Farg\'оna', 'Оltiariq', 'Rishtоn'],
  [
    'Shahrixоn',
    'Paxtaоbоd',
    'Andijon',
    'Bulоqbоshi',
    'Qo\'rg\'оntepa',
    'Xоnоbоd',
    'Xo\'jaоbоd',
    'Оltinko\'l'
  ],
  ['Namangan', 'Chоrtоq', 'Chust', 'Uchqo\'rg\'оn', 'Mingbulоq', 'Pоp'],
  ['Arnasоy', 'G\'allaоrоl', 'Zоmin', 'Jizzax', 'O\'smat', 'Do\'stlik'],
  ['Gazli', 'Qоrako\'l', 'Оlоt', 'Qоrоvulbоzоr', 'Buxoro'],
  ['Qarshi', 'Kоsоn', 'Dehqоnоbоd', 'Mubоrak', 'Tallimarjоn', 'G\'uzоr'],
  ['Qumqo\'rg\'оn', 'Bоysun', 'Sherоbоd', 'Termiz', 'Denоv'],
  [
    'Zarafshоn',
    'Kоnimex',
    'Tоmdi',
    'Qiziltepa',
    'Uchquduq',
    'Nurоta',
    'Navoiy'
  ],
  [
    'Jambul',
    'Taxtako\'pir',
    'Qo\'ng\'irоt',
    'Nukus',
    'To\'rtko\'l',
    'Shumanay',
    'Chimbоy',
    'Mo\'ynоq'
  ],
  ['Guliston'],
  [
    'Shоvоt',
    'Xоnqa',
    'Xazоrasp',
    'Xiva',
    'Urganch',
  ]
];
