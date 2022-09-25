import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void urlLaunch(BuildContext context) async {
  final Uri url = Uri.parse('https://namoz.islom.uz/namoz.html');
  try {
    await launchUrl(url);
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Link ochishda xatolik')));
  }
}
