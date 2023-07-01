import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';

import '../model/size_variation.dart';
import '../util/screen_size.dart';

class WorkExperiencePanelHeaderWidget extends StatelessWidget {
  WorkExperiencePanelHeaderWidget({super.key, required this.workExperience});
  WorkExperience workExperience;

  @override
  Widget build(BuildContext context) {
    final largeFontSizeVariation = SizeVariation(
      whenType4K: 32,
      whenTypeLaptopLarge: 32.0,
      whenTypeLaptop: 24.0,
      whenTypeTablet: 24.0,
      whenTypeMobileLarge: 24.0,
      whenTypeMobileMedium: 24.0,
      whenTypeMobileSmall: 24.0,
    );
    final smallFontSizeVariation = SizeVariation(
      whenType4K: 20.0,
      whenTypeLaptopLarge: 20.0,
      whenTypeLaptop: 12.0,
      whenTypeTablet: 12.0,
      whenTypeMobileLarge: 12.0,
      whenTypeMobileMedium: 12.0,
      whenTypeMobileSmall: 12.0,
    );

    final mediumTextStyle = TextStyle(
        fontSize: smallFontSizeVariation.getSizeWithContext(context),
        color: Colors.black,
        fontWeight: FontWeight.w400);

    final largeTextStyle = TextStyle(
        fontSize: largeFontSizeVariation.getSizeWithContext(context),
        color: Colors.black,
        fontWeight: FontWeight.w500);

    const comapnyString = 'Comapny';
    const locationString = 'Location';
    const roleString = 'Role';
    const rankString = 'Rank';
    const periodString = 'Work Period';

    final flexs = <int>[3, 1, 1, 2, 1];

    if (ScreenSize.isTabletScreenSize(context)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comapnyString,
                        style: mediumTextStyle.copyWith(color: Colors.grey),
                      ),
                      Text(
                        workExperience.companyName,
                        style: largeTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locationString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.location,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      rankString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.rank,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      roleString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.mainRole,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      periodString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.workPeriod,
                      style: mediumTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (ScreenSize.isMobileScreenSize(context)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comapnyString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.companyName,
                      style: largeTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      locationString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.location,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      rankString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.rank,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      roleString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.mainRole,
                      style: mediumTextStyle,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      periodString,
                      style: mediumTextStyle.copyWith(color: Colors.grey),
                    ),
                    Text(
                      workExperience.workPeriod,
                      style: mediumTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[0],
              child: Center(
                child: Text(
                  workExperience.companyName,
                  style: largeTextStyle,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[1],
              child: Text(
                workExperience.location,
                style: mediumTextStyle,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[2],
              child: Text(
                workExperience.rank,
                style: mediumTextStyle,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[3],
              child: Text(
                workExperience.mainRole,
                style: mediumTextStyle,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[4],
              child: Text(
                workExperience.workPeriod,
                style: mediumTextStyle,
              ),
            ),
          ],
        ),
      );
    }
  }
}
