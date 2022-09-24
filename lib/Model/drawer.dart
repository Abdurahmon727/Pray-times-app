import 'package:flutter/material.dart';
import 'package:namoz_vaqtlari/Model/regions.dart';

Drawer myDrawer(BuildContext context) => Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFD6239),
            ),
            child: Image.asset(
              'assets/splash.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/notificationPage');
            },
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(
                'Bildirishnoma',
                style: TextStyle(fontSize: currentFontSize),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/locationPage');
            },
            child: ListTile(
              leading: const Icon(Icons.edit_location),
              title: Text(
                'Joylashuv',
                style: TextStyle(fontSize: currentFontSize),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/settingsPage');
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Sozlamalar',
                style: TextStyle(fontSize: currentFontSize),
              ),
            ),
          ),
        ],
      ),
    );
