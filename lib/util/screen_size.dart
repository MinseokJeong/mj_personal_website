import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';

class ScreenSize {
  ScreenSize._();

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isLargeScreenSize(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    return (ScreenType.laptopLarge.width < screenWidth) ? true : false;
  }

  static bool isLaptopScreenSize(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    return (ScreenType.laptopLarge.width >= screenWidth &&
            ScreenType.tablet.width < screenWidth)
        ? true
        : false;
  }

  static bool isTabletScreenSize(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    return (ScreenType.tablet.width >= screenWidth &&
            ScreenType.mobileLarge.width < screenWidth)
        ? true
        : false;
  }

  static bool isMobileScreenSize(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    return (ScreenType.mobileLarge.width >= screenWidth) ? true : false;
  }
}
