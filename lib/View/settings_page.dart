import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../Model/regions.dart';
import '../assets/consts.dart';
import '../data/hive_data.dart';
import '../logic/cubit/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double newFontSize = currentFontSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Sozlamalar',
          style: TextStyle(fontSize: currentFontSize + 3),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 20),
          const Text(
            '*Dastur yaratuvchilari dasturdagi namoz vaqtlari aniqligi va Namoz o\'qish tartib-qoidalariga nomasuldirlar. Barcha resurslar rasmiy islom.uz va namoz.islom.uz dan olinadi.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text(
            'Dastur Rejimi',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: currentFontSize),
          ),
          ListTile(
            title: Text(
              'Dastur rejimi sifatida qurilma rejimidan foydalanish',
              style: TextStyle(fontSize: currentFontSize),
            ),
            trailing: Switch(
              activeColor: kprimaryColor,
              onChanged: (value) {
                setState(() {
                  isSystemMode = value;
                });

                if (value == true) {
                  BlocProvider.of<ThemeCubit>(context)
                      .changeTheme(ThemeMode.system);

                  putData('currentTheme', 'ThemeMode.system');
                } else {
                  if (ThemeMode.system == ThemeMode.dark) {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(ThemeMode.dark);

                    putData('currentTheme', 'ThemeMode.dark');
                  } else {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(ThemeMode.light);

                    putData('currentTheme', 'ThemeMode.light');
                  }
                }
              },
              value: isSystemMode,
            ),
          ),
          Visibility(
            visible: !isSystemMode,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.read<ThemeCubit>().state.currentTheme !=
                        ThemeMode.light) {
                      context.read<ThemeCubit>().changeTheme(ThemeMode.light);
                      putData('currentTheme', 'ThemeMode.light');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color:
                            (context.watch<ThemeCubit>().state.currentTheme ==
                                    ThemeMode.light)
                                ? kprimaryColor
                                : Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Kunduzgi',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (context.read<ThemeCubit>().state.currentTheme !=
                        ThemeMode.dark) {
                      context.read<ThemeCubit>().changeTheme(ThemeMode.dark);

                      putData('currentTheme', 'ThemeMode.dark');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color:
                            (context.watch<ThemeCubit>().state.currentTheme ==
                                    ThemeMode.dark)
                                ? kprimaryColor
                                : Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Tungi',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Dastur shrift o\'lchami',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: currentFontSize),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              children: [
                Text(
                  'Ayni vaqtdagi shrift o\'lchami: ${newFontSize.toInt()}',
                  style: TextStyle(
                      backgroundColor: Colors.grey,
                      fontSize: newFontSize,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          Slider(
              activeColor: kprimaryColor,
              inactiveColor: Colors.grey,
              min: 14,
              max: 30,
              value: newFontSize,
              onChanged: (value) {
                setState(() {
                  newFontSize = value;
                });
                putData('currentFontSize', value);
              }),
          TextButton(
            child: Text(
              'Yangi shrift o\'lchamini joriy qilish uchun dasturni qayta ishga tushiring',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                  color: kprimaryColor, fontSize: currentFontSize - 2),
            ),
            onPressed: () {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          'Yangi sozlamalarni joriy qilish uchun dasturni qayta yuklash talab qilinadi!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Keyinroq',
                            style: GoogleFonts.workSans(color: Colors.blueGrey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Restart.restartApp(webOrigin: '/main');
                          },
                          child: Text(
                            'Qayta yuklash',
                            style: GoogleFonts.workSans(color: kprimaryColor),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

          // Text(
          //   'Tilni o\'zgartirish',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontSize: currentFontSize),
          // ),
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         if (currentLanguage != Language.uzbek) {
          //           setState(() {
          //             currentLanguage = Language.uzbek;
          //           });
          //           putData('currentLanguage', 'uzbek');
          //         }
          //       },
          //       child: Container(
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 4,
          //         decoration: BoxDecoration(
          //             color: (currentLanguage == Language.uzbek)
          //                 ? kprimaryColor
          //                 : Colors.grey,
          //             borderRadius:
          //                 const BorderRadius.all(Radius.circular(20))),
          //         child: const Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               'Uzbek',
          //               style: TextStyle(fontSize: 16),
          //             )),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         if (currentLanguage != Language.kril) {
          //           setState(() {
          //             currentLanguage = Language.kril;
          //           });
          //           putData('currentLanguage', 'kril');
          //         }
          //       },
          //       child: Container(
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 4,
          //         decoration: BoxDecoration(
          //             color: (currentLanguage == Language.kril)
          //                 ? kprimaryColor
          //                 : Colors.grey,
          //             borderRadius:
          //                 const BorderRadius.all(Radius.circular(20))),
          //         child: const Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               'Krilcha',
          //               style: TextStyle(fontSize: 16),
          //             )),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         if (currentLanguage != Language.ruskiy) {
          //           setState(() {
          //             currentLanguage = Language.ruskiy;
          //           });
          //           putData('currentLanguage', 'ruskiy');
          //         }
          //       },
          //       child: Container(
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 4,
          //         decoration: BoxDecoration(
          //             color: (currentLanguage == Language.ruskiy)
          //                 ? kprimaryColor
          //                 : Colors.grey,
          //             borderRadius:
          //                 const BorderRadius.all(Radius.circular(20))),
          //         child: const Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               'Ruskiy',
          //               style: TextStyle(fontSize: 16),
          //             )),
          //       ),
          //     ),
          //   ],
          // ),
          //const SizedBox(height: 10),