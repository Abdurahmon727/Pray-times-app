import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namoz_vaqtlari/Model/consts.dart';
import 'package:url_launcher/url_launcher.dart';

void urlLaunch(BuildContext context) async {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext _) {
        return AlertDialog(
          title: const Text('Havolani ochish'),
          content: const Text(
              'Nomoz o\'qish taribini ko\'rish uchun quyidagi havolani oching.\nhttps://namoz.islom.uz/namoz.html '),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Bekor qilish',
                  style: GoogleFonts.workSans(color: Colors.blueGrey),
                )),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  final Uri url =
                      Uri.parse('https://namoz.islom.uz/namoz.html');
                  try {
                    await launchUrl(url);
                  } catch (e) {
                    print('ERROR ON LAUNCHING URL: $e');
                  }
                },
                child: Text(
                  'Ochish',
                  style: GoogleFonts.workSans(color: kprimaryColor),
                )),
          ],
        );
      });
}
