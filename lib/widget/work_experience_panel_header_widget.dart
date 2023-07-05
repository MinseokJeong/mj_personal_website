import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';
import 'package:mj_portfolio_web/widget/work_experience_widget.dart';

import '../model/size_variation.dart';
import '../util/screen_size.dart';

class WorkExperiencePanelHeaderWidget extends StatelessWidget {
  WorkExperiencePanelHeaderWidget({super.key, required this.workExperience});
  WorkExperience workExperience;

  final _headerTextColor = Color(0xff747474);
  final _largeTextColor = Color(0xff363533);
  final _mediumTextColor = Color(0xff434343);

  @override
  Widget build(BuildContext context) {
    const companyString = 'Company';
    const locationString = 'Location';
    const roleString = 'Role';
    const rankString = 'Rank';
    const periodString = 'Work Period';

    const flexs = WorkExperiencesWidget.flexs;

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
                      _topHeaderTextWidget(companyString, context),
                      _largeTextWidget(workExperience.companyName, context),
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
                    _topHeaderTextWidget(locationString, context),
                    _mediumTextWidget(workExperience.location, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(rankString, context),
                    _mediumTextWidget(workExperience.rank, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(roleString, context),
                    _mediumTextWidget(workExperience.mainRole, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(periodString, context),
                    _mediumTextWidget(workExperience.workPeriod, context),
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
                    _topHeaderTextWidget(companyString, context),
                    _largeTextWidget(workExperience.companyName, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(locationString, context),
                    _mediumTextWidget(workExperience.location, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(rankString, context),
                    _mediumTextWidget(workExperience.rank, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(roleString, context),
                    _mediumTextWidget(workExperience.mainRole, context),
                    SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(periodString, context),
                    _mediumTextWidget(workExperience.workPeriod, context),
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
                child: _largeTextWidget(workExperience.companyName, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[1],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(workExperience.location, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[2],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(workExperience.rank, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[3],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(workExperience.mainRole, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[4],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(workExperience.workPeriod, context),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _topHeaderTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 20.0,
      whenTypeLaptopLarge: 20.0,
      whenTypeLaptop: 12.0,
      whenTypeTablet: 12.0,
      whenTypeMobileLarge: 10.0,
      whenTypeMobileMedium: 10.0,
      whenTypeMobileSmall: 10.0,
    );

    final textStyle = TextStyle(
        fontSize: fontSizeVariation.getSizeWithContext(context),
        color: _headerTextColor,
        fontWeight: FontWeight.w400);
    return Text(
      text,
      style: textStyle,
    );
  }

  Widget _largeTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 32,
      whenTypeLaptopLarge: 32.0,
      whenTypeLaptop: 24.0,
      whenTypeTablet: 24.0,
      whenTypeMobileLarge: 20.0,
      whenTypeMobileMedium: 20.0,
      whenTypeMobileSmall: 20.0,
    );

    final textStyle = TextStyle(
        fontSize: fontSizeVariation.getSizeWithContext(context),
        color: _largeTextColor,
        fontWeight: FontWeight.w500);

    return Text(
      text,
      style: textStyle,
    );
  }

  Widget _mediumTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 20.0,
      whenTypeLaptopLarge: 20.0,
      whenTypeLaptop: 18.0,
      whenTypeTablet: 18.0,
      whenTypeMobileLarge: 14.0,
      whenTypeMobileMedium: 14.0,
      whenTypeMobileSmall: 14.0,
    );

    final textStyle = TextStyle(
        fontSize: fontSizeVariation.getSizeWithContext(context),
        color: _mediumTextColor,
        fontWeight: FontWeight.w400);
    return Text(
      text,
      style: textStyle,
    );
  }
}
