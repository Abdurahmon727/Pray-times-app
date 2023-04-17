import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../Model/drawer.dart';
import '../Model/regions.dart';
import '../assets/consts.dart';
import '../data/api.dart';
import '../data/url_launcher.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Repository.getTimes(currentDistict, context);
      //await AwesomeNotifications().cancelAllSchedules();

      setState(() {
        currentDate;
        currentDay;
        currentPlace;
        currentNamozTimes;
      });
    });
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            barrierDismissible: false,
            barrierColor: kprimaryColor,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Notification Access'),
                content: const Text('Dastur bildirishnoma uchun rusxsat kerak'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Rad etish')),
                  TextButton(
                      onPressed: () {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context));
                      },
                      child: const Text('Ruxsat berish'))
                ],
              );
            });
      }
    });

    makeDropdowns(regions, regionsItem);
    makeDropdowns2(disticts, distictItem);
  }

  Future<void> onRefresh() async {
    await Repository.getTimes(currentDistict, context);

    setState(() {
      currentDate;
      currentDay;
      currentPlace;
      currentNamozTimes;
    });
    await AwesomeNotifications().cancelAllSchedules();
    for (int i = 0; i < 5; i++) {
      await namozNotification[i].acivateNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(child: myDrawer(context)),
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Namoz vaqtlari',
          style: TextStyle(fontSize: currentFontSize + 3),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Text(
            '$currentPlace | $currentDate | $currentDay',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: currentFontSize - (currentFontSize / 6),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        //edgeOffset: -10,
        displacement: 10,
        color: kprimaryColor,
        onRefresh: () async {
          await onRefresh();
        },
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/moon to sun.png',
                  width: 40,
                ),
                title: Text(
                  'Bomdod',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[0],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/sun_up.png',
                  width: 40,
                ),
                title: Text(
                  'Quyosh',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[1],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/sun.png',
                  width: 40,
                ),
                title: Text(
                  'Peshin',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[2],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/sun_down.png',
                  width: 40,
                ),
                title: Text(
                  'Asr',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[3],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/sun to moon.png',
                  width: 40,
                ),
                title: Text(
                  'Shom',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[4],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                urlLaunch(context);
              },
              child: ListTile(
                leading: Image.asset(
                  'icons/moon.png',
                  width: 40,
                ),
                title: Text(
                  'Xufton',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                trailing: Text(
                  currentNamozTimes[5],
                  style: TextStyle(fontSize: currentFontSize - 2),
                ),
              ),
            ),
            Visibility(
                visible: (currentDay == 'Juma') ? true : false,
                child: Image.asset(
                  'assets/juma_muborak.png',
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }
}
