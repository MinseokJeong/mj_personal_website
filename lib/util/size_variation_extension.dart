import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';

import '../model/size_variation.dart';

extension SizeVariationExtension on SizeVariation {
  double getSizeWithScreenType(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.fourK:
        return whenType4K;
      case ScreenType.laptopLarge:
        return whenTypeLaptopLarge;
      case ScreenType.laptop:
        return whenTypeLaptop;
      case ScreenType.tablet:
        return whenTypeTablet;
      case ScreenType.mobileLarge:
        return whenTypeMobileLarge;
      case ScreenType.mobileMedium:
        return whenTypeMobileMedium;
      case ScreenType.mobileSmall:
        return whenTypeMobileSmall;
    }
  }

  double getSizeWithContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenType = ScreenTypeExtension.getScreenType(width);

    return getSizeWithScreenType(screenType);
  }
}
