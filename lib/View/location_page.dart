import 'package:flutter/material.dart';

import 'package:namoz_vaqtlari/Model/api.dart';

import '../Model/hive_data.dart';
import '../Model/regions.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Joylashuv',
          style: TextStyle(fontSize: currentFontSize + 3),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              '* Afsuski ayni vaqtda O\'zbekistondagi barcha tumanlar dasturimizda mavjud emas. Agarda sizning yashash mazilingiz ham kiritilmagan bo\'lsa o\'zingizga eng yaqin yerni tanlashingizni maslahat beramiz. Noqulayliklar uchun uzur so\'raymiz.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Viloyat tanlang:',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                DropdownButton<int>(
                  icon: const Icon(Icons.expand_more),
                  value: currentRegion,
                  onChanged: (value) {
                    setState(() {
                      currentRegion = value ?? 0;
                      currentDistict = disticts[currentRegion][0];
                    });
                    putData('currentRegion', currentRegion);
                    putData('currentDistict', currentDistict);
                    //getTimes(currentDistict, context);
                  },
                  items: regionsItem,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tuman/shahar tanlang:',
                  style: TextStyle(fontSize: currentFontSize),
                ),
                DropdownButton<String>(
                  icon: const Icon(Icons.expand_more),
                  value: currentDistict,
                  onChanged: (value) {
                    setState(() {
                      currentDistict = value ?? '';
                    });
                    putData('currentDistict', currentDistict);

                    //getTimes(currentDistict, context);
                  },
                  items: distictItem[currentRegion],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
