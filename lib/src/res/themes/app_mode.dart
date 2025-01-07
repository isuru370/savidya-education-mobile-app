import 'package:aloka_mobile_app/src/res/color/app_color.dart';
import 'package:flutter/material.dart';

import 'hex_color.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ColorUtil.tealColor[10]!,
      onPrimary: ColorUtil.tealColor[16]!,
      secondary: ColorUtil.blackColor[10]!,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            side: BorderSide(width: 0.5, color: ColorUtil.tealColor[10]!))));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: HexColor('#202231'),
    secondary: HexColor('#3d6adb'),
  ),
  fontFamily: 'Oswald',
);
