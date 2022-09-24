// ignore_for_file: prefer_const_constructors

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
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
  if (localFile.get('currentTheme') == 'system') {
    currentTheme = ThemeMode.system;
    isSystemMode = true;
  } else if (localFile.get('currentTheme') == 'dark') {
    currentTheme = ThemeMode.dark;
    isSystemMode = false;
  } else {
    currentTheme = ThemeMode.light;
    isSystemMode = false;
  }

  // List<NotificationForNamoz> namozNotification = [
  //   NotificationForNamoz('Bomdod', isNotificationEnabled[0], 0),
  //   NotificationForNamoz('Peshin', isNotificationEnabled[1], 1),
  //   NotificationForNamoz('Asr', isNotificationEnabled[2], 2),
  //   NotificationForNamoz('Shom', isNotificationEnabled[3], 3),
  //   NotificationForNamoz('Xufton', isNotificationEnabled[4], 4),
  // ];

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

  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: GoogleFonts.workSans(),
          titleLarge: GoogleFonts.workSans(),
          bodyLarge: GoogleFonts.workSans(),
          bodyMedium: GoogleFonts.workSans(),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kprimaryColor,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        splashColor: kprimaryColor,
        primaryColor: kprimaryColor,
      ),
      darkTheme: ThemeData(
          textTheme: TextTheme(
            titleMedium: GoogleFonts.workSans(),
            titleLarge: GoogleFonts.workSans(),
            bodyLarge: GoogleFonts.workSans(),
            bodyMedium: GoogleFonts.workSans(),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: kprimaryColor,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          splashColor: kprimaryColor,
          primaryColor: kprimaryColor,
          brightness: Brightness.dark),
      themeMode: currentTheme,
      title: 'Namoz vaqtlari',
      initialRoute: '/homePage',
      routes: {
        '/homePage': (context) => HomePage(),
        '/settingsPage': (context) => SettingsPage(),
        '/locationPage': (context) => LocationPage(),
        '/notificationPage': (context) => NotificationPage(),
      },
    ),
  );
}
