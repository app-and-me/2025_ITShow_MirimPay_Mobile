import 'dart:ui';
import 'package:flutter/material.dart';

class PrimaryColors {
  final Color primary;
  final Color secondary;

  PrimaryColors({
    required this.primary,
    required this.secondary,
  });

  static PrimaryColors of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PrimaryColors(
      primary: isDarkMode ? const Color(0xff249D57) : const Color(0xff249D57),
      secondary: isDarkMode ? const Color(0xff38C172) : const Color(0xff38C172),
    );
  }
}

class PalettePrimary {
  final Color light;
  final Color lightHover;
  final Color lightActive;
  final Color normal;
  final Color normalHover;
  final Color normalActive;
  final Color dark;
  final Color darkHover;
  final Color darkActive;
  final Color darker;

  PalettePrimary({
    required this.light,
    required this.lightHover,
    required this.lightActive,
    required this.normal,
    required this.normalHover,
    required this.normalActive,
    required this.dark,
    required this.darkHover,
    required this.darkActive,
    required this.darker,
  });

  static PalettePrimary of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PalettePrimary(
      light: isDarkMode ? const Color(0xffE9F5EE) : const Color(0xffE9F5EE),
      lightHover: isDarkMode ? const Color(0xffDEF0E6) : const Color(0xffDEF0E6),
      lightActive: isDarkMode ? const Color(0xffBBE1CB) : const Color(0xffBBE1CB),
      normal: isDarkMode ? const Color(0xff249D57) : const Color(0xff249D57),
      normalHover: isDarkMode ? const Color(0xff208D4E) : const Color(0xff208D4E),
      normalActive: isDarkMode ? const Color(0xff1D7E46) : const Color(0xff1D7E46),
      dark: isDarkMode ? const Color(0xff1B7641) : const Color(0xff1B7641),
      darkHover: isDarkMode ? const Color(0xff165E34) : const Color(0xff165E34),
      darkActive: isDarkMode ? const Color(0xff104727) : const Color(0xff104727),
      darker: isDarkMode ? const Color(0xff0D371E) : const Color(0xff0D371E),
    );
  }
}

class Gray {
  final Color gray50;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray800;
  final Color gray900;

  Gray({
    required this.gray50,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray800,
    required this.gray900,
  });

  static Gray of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Gray(
      gray50: isDarkMode ? const Color(0xffFEFFFE) : const Color(0xffFEFFFE),
      gray100: isDarkMode ? const Color(0xffF5F5F5) : const Color(0xffF5F5F5),
      gray200: isDarkMode ? const Color(0xffEEEEEE) : const Color(0xffEEEEEE),
      gray300: isDarkMode ? const Color(0xffE0E0E0) : const Color(0xffE0E0E0),
      gray400: isDarkMode ? const Color(0xffBDBDBD) : const Color(0xffBDBDBD),
      gray500: isDarkMode ? const Color(0xff9E9E9E) : const Color(0xff9E9E9E),
      gray600: isDarkMode ? const Color(0xff757575) : const Color(0xff757575),
      gray700: isDarkMode ? const Color(0xff616161) : const Color(0xff616161),
      gray800: isDarkMode ? const Color(0xff424242) : const Color(0xff424242),
      gray900: isDarkMode ? const Color(0xff212121) : const Color(0xff212121),
    );
  }
}

class System {
  final Color red;
  final Color green;
  final Color yellow;

  System({
    required this.red,
    required this.green,
    required this.yellow,
  });

  static System of(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return System(
      red: isDarkMode ? const Color(0xffD32F2F) : const Color(0xffD32F2F),
      green: isDarkMode ? const Color(0xff4CAF50) : const Color(0xff4CAF50),
      yellow: isDarkMode ? const Color(0xffF9A825) : const Color(0xffF9A825),
    );
  }
}