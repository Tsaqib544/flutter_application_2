import 'package:flutter/material.dart';

class AppColors {
  static const darkGrey = Color(0XFF635C5C);
  static const darkBlue = Color(0XFF0B6EFE);
  static const lightBlue = Color(0XFF6699CC);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const lightGrey = Color(0xFFB0B0B0);
  static const primary = darkBlue;
  static const secondary = darkGrey;
}

class TextStyles {
  static TextStyle title = const TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: AppColors.darkGrey,
  );

  static TextStyle body = const TextStyle(
    fontFamily: 'Outfit',
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    color: AppColors.darkGrey,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );
}
