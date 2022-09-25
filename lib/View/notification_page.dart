import 'package:flutter/material.dart';
import 'package:namoz_vaqtlari/Model/consts.dart';
import 'package:namoz_vaqtlari/Model/regions.dart';

import '../Model/notification.dart';

List<NotificationForNamoz> namozNotification = [
  NotificationForNamoz('Bomdod', isNotificationEnabled[0], 0),
  NotificationForNamoz('Peshin', isNotificationEnabled[1], 1),
  NotificationForNamoz('Asr', isNotificationEnabled[2], 2),
  NotificationForNamoz('Shom', isNotificationEnabled[3], 3),
  NotificationForNamoz('Xufton', isNotificationEnabled[4], 4),
];

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Bildirishnoma'),
      ),
      body: ListView.builder(
        itemCount: namozNotification.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(namozNotification[index].name),
          trailing: Switch(
            activeColor: kprimaryColor,
            value: namozNotification[index].isNotify,
            onChanged: (value) {
              setState(() {
                namozNotification[index]
                    .changeNotificationEnabled(value, context);
              });
            },
          ),
        ),
      ),
    );
  }
}
