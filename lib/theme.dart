import 'package:flutter/material.dart';

// Color constants
const Color kPrimaryColor = Color(0xFF8B0000); // Merah Marun
const Color kAccentColor = Color(0xFF00C853); // Hijau Aksen
const Color kTextColor = Color(0xFF212121); // Teks gelap
const Color kBackgroundColor = Color(0xFFFFFFFF); // Putih

// Text styles
const TextStyle kHeaderTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

const TextStyle kBodyTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

// A minimal ThemeData convenience getter
ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: kAccentColor,
      background: kBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
