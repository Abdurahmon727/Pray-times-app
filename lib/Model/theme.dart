import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../assets/consts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    titleMedium: GoogleFonts.workSans(),
    titleLarge: GoogleFonts.workSans(),
    bodyLarge: GoogleFonts.workSans(),
    bodyMedium: GoogleFonts.workSans(),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kprimaryColor,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  brightness: Brightness.light,
  splashColor: kprimaryColor,
  primaryColor: kprimaryColor,
);

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      titleMedium: GoogleFonts.workSans(),
      titleLarge: GoogleFonts.workSans(),
      bodyLarge: GoogleFonts.workSans(),
      bodyMedium: GoogleFonts.workSans(),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kprimaryColor,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    splashColor: kprimaryColor,
    primaryColor: kprimaryColor,
    brightness: Brightness.dark);
