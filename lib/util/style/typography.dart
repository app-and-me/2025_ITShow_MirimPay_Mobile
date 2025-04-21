import 'package:flutter/material.dart';

class Typo {
  static const String fontFamily = 'Pretendard';

  static TextStyle hero(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w600,
      height: 1.20,
      letterSpacing: -1.44,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    );
  }

  static TextStyle headlineLg(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.20,
      letterSpacing: -0.96,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    );
  }

  static TextStyle headlineMd(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 21,
      fontWeight: FontWeight.w600,
      height: 1.20,
      letterSpacing: -0.84,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    );
  }
  
  static TextStyle headlineSm(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.20,
      letterSpacing: -0.72,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    );
  }

  static TextStyle subheading(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.20,
      letterSpacing: -0.72,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
    );
  }

  static TextStyle bodyMd(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: -0.32,
      color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
    );
  }

  static TextStyle bodySm(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: -0.28,
      color: color ?? Theme.of(context).textTheme.bodySmall?.color,
    );
  }

  static TextStyle button(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.20,
      color: color ?? Theme.of(context).textTheme.labelLarge?.color,
    );
  }

  static TextStyle caption(BuildContext context, {Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.40,
      letterSpacing: -0.24,
      color: color ?? Theme.of(context).textTheme.bodySmall?.color,
    );
  }
}