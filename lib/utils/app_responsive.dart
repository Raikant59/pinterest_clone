import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppResponsive {
  AppResponsive._();

  static const double _designWidth = 393.0;
  static const double _designHeight = 852.0;

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double scaleWidth(BuildContext context) {
    return screenWidth(context) / _designWidth;
  }

  static double scaleHeight(BuildContext context) {
    return screenHeight(context) / _designHeight;
  }

  static double scale(BuildContext context) {
    return math.min(scaleWidth(context), scaleHeight(context));
  }

  static double w(BuildContext context, double value) {
    return value * scaleWidth(context);
  }

  static double h(BuildContext context, double value) {
    return value * scaleHeight(context);
  }

  static double r(BuildContext context, double value) {
    return value * scale(context);
  }

  static double sp(BuildContext context, double value) {
    final textScale = scale(context);
    return value * textScale;
  }

  static bool isSmallPhone(BuildContext context) {
    return screenWidth(context) < 360;
  }

  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= 700;
  }
}