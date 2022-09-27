// ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:namoz_vaqtlari/Model/theme.dart';
import 'package:namoz_vaqtlari/View/home_page.dart';
import 'package:namoz_vaqtlari/View/location_page.dart';
import 'package:namoz_vaqtlari/View/notification_page.dart';
import 'package:namoz_vaqtlari/View/settings_page.dart';
import 'package:namoz_vaqtlari/Model/consts.dart';
import 'package:namoz_vaqtlari/Model/regions.dart';

void main() async {
  //notification initialize
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'Namoz_times_key',
        channelName: 'Namoz times',
        defaultColor: kprimaryColor,
        importance: NotificationImportance.High,
        playSound: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        channelShowBadge: true,
        channelDescription:
            'This channel makes notifications about Namoz times'),
  ]);

  //hive
  await Hive.initFlutter();
  var localFile = await Hive.openBox('myBox');
  currentRegion = localFile.get('currentRegion') ?? 0;
  currentDistict = localFile.get('currentDistict') ?? 'Toshkent';
  currentFontSize = localFile.get('currentFontSize') ?? 16;
  isNotificationEnabled = await localFile.get('isNotificationEnabled') ??
      [false, false, false, false, false];
//language for hive
  if (localFile.get('currentLanguage') == 'ruskiy') {
    currentLanguage = Language.ruskiy;
  } else if (localFile.get('currentLanguage') == 'kril') {
    currentLanguage = Language.kril;
  } else {
    currentLanguage = Language.uzbek;
  }
  //theme for hive
  String hiveTheme = await localFile.get('currentTheme') ?? 'light';
  if (hiveTheme == 'system') {
    currentTheme = ThemeMode.system;
    isSystemMode = true;
  } else if (hiveTheme == 'dark') {
    currentTheme = ThemeMode.dark;
    isSystemMode = false;
  } else {
    currentTheme = ThemeMode.light;
    isSystemMode = false;
  }

//action stream
  AwesomeNotifications().actionStream.listen((_) {
    AwesomeNotifications()
        .getGlobalBadgeCounter()
        .then((value) => AwesomeNotifications().setGlobalBadgeCounter(0));
  });
  //dismissed stream
  AwesomeNotifications().dismissedStream.listen((_) {
    AwesomeNotifications()
        .getGlobalBadgeCounter()
        .then((value) => AwesomeNotifications().setGlobalBadgeCounter(0));
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme,
      title: 'Namoz vaqtlari',
      initialRoute: '/homePage',
      routes: {
        '/homePage': (context) => HomePage(),
        '/settingsPage': (context) => SettingsPage(),
        '/locationPage': (context) => LocationPage(),
        '/notificationPage': (context) => NotificationPage(),
      },
    );
  }
}
