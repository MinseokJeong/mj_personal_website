import 'package:flutter/material.dart';

class ScreenSize {
  ScreenSize._();
  static const double _largeScreenWidth = 720.0;

  static bool isLargeScreenSize(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return (screenSize.width > _largeScreenWidth) ? true : false;
  }

  static bool isNotLargeScreenSize(BuildContext context) {
    return !isLargeScreenSize(context);
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
