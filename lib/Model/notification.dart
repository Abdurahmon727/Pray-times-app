import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:namoz_vaqtlari/data/hive_data.dart';
import 'package:namoz_vaqtlari/Model/regions.dart';

import '../logic/cubit/theme_cubit.dart';

Future<void> createNotification(String name, String time, int id) async {
  print(time);
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'Namoz_times_key',
      title: '$name vaqti bo\'ldi',
      body: 'Namoz musilmonlar uchun farzdir',
    ),
    schedule: NotificationCalendar(
      allowWhileIdle: true,
      repeats: true,
      hour: int.parse(time[0] + time[1]),
      minute: int.parse(time[3] + time[4]),
      second: 00,
    ),
  );
}

//class
class NotificationForNamoz {
  String name;
  bool isNotify;
  int id;

  NotificationForNamoz(this.name, this.isNotify, this.id);

  Future<void> acivateNotification() async {
    if (isNotify) {
      late String fileLocation;
      if (id != 0) {
        fileLocation = currentNamozTimes[id + 1];
      } else {
        fileLocation = currentNamozTimes[0];
      }
      await createNotification(name, fileLocation, id);
    }
  }

  void changeNotificationEnabled(bool willNotify, BuildContext context) async {
    isNotify = willNotify;
    isNotificationEnabled[id] = willNotify;
    putData('isNotificationEnabled', isNotificationEnabled);
    if (isNotify) {
      late String fileLocation;
      if (id != 0) {
        fileLocation = currentNamozTimes[id + 1];
      } else {
        fileLocation = currentNamozTimes[0];
      }
      await createNotification(name, fileLocation, id).then(
        (_) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$name namozi uchun bildirishnoma yoqildi'),
                  Icon(
                    Icons.event_available,
                    color: (BlocProvider.of<ThemeCubit>(context).getTheme() ==
                            ThemeMode.light)
                        ? Colors.white
                        : Colors.black,
                  )
                ]),
            duration: const Duration(milliseconds: 1000),
          ),
        ),
      );
    } else {
      await AwesomeNotifications().cancel(id).then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$name namozi uchun bildirishnoma o\'chirildi'),
                      Icon(
                        Icons.event_busy,
                        color:
                            (BlocProvider.of<ThemeCubit>(context).getTheme() ==
                                    ThemeMode.light)
                                ? Colors.white
                                : Colors.black,
                      )
                    ]),
                duration: const Duration(milliseconds: 500),
              ),
            ),
          );
    }
  }
}
