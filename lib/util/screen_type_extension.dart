import 'package:flutter/material.dart';

import '../model/enum_screen_type.dart';

extension ScreenTypeExtension on ScreenType {
  static ScreenType? baseScreenType;

  double get width {
    switch (this) {
      case ScreenType.fourK:
        return 2560;
      case ScreenType.laptopLarge:
        return 1440;
      case ScreenType.laptop:
        return 1024;
      case ScreenType.tablet:
        return 768;
      case ScreenType.mobileLarge:
        return 425;
      case ScreenType.mobileMedium:
        return 375;
      case ScreenType.mobileSmall:
        return 320;
    }
  }

  static ScreenType getScreenType(num deviceWidth) {
    const screenTypes = ScreenType.values;

    for (int i = 0; i < screenTypes.length; ++i) {
      if (deviceWidth >= screenTypes[i].width) {
        return screenTypes[i];
      }
    }
    return screenTypes.last;
  }

  static double calculateRatioBasedOnBaseScreenType(
      ScreenType currentScreenType) {
    if (baseScreenType == null) {
      print('Please setup baseScreenType');
      return 1.0;
    }

    return currentScreenType.width / baseScreenType!.width;
  }

  static double calculateRatioWithContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return screenWidth / baseScreenType!.width;
  }
}
