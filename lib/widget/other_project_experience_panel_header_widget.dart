import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/project_information.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';

import '../model/size_variation.dart';
import '../util/screen_size.dart';
import 'other_project_experience_widget.dart';

class OtherProjectExperiencePanelHeaderWidget extends StatelessWidget {
  OtherProjectExperiencePanelHeaderWidget(
      {super.key, required this.projectInformation});

  ProjectInformation projectInformation;

  @override
  Widget build(BuildContext context) {
    const flexs = OtherProjectExperiencesWidget.flexs;

    const projectNameString = 'Project Name';
    const descriptionStirng = 'Description';
    const workPeriodString = 'Work Period';

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
                      _topHeaderTextWidget(projectNameString, context),
                      _largeTextWidget(projectInformation.projectName, context),
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
                    _topHeaderTextWidget(descriptionStirng, context),
                    _mediumTextWidget(
                        projectInformation.projectDescription, context),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(workPeriodString, context),
                    _mediumTextWidget(
                        projectInformation.projectPeriod, context),
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
                    _topHeaderTextWidget(projectNameString, context),
                    _largeTextWidget(projectInformation.projectName, context),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(descriptionStirng, context),
                    _mediumTextWidget(
                        projectInformation.projectDescription, context),
                    const SizedBox(
                      height: 8.0,
                    ),
                    _topHeaderTextWidget(workPeriodString, context),
                    _mediumTextWidget(
                        projectInformation.projectPeriod, context),
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
                child:
                    _largeTextWidget(projectInformation.projectName, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[1],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(
                    projectInformation.projectDescription, context),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: flexs[2],
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _mediumTextWidget(
                    projectInformation.projectPeriod, context),
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
        color: Colors.black,
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
        color: Colors.black,
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
        color: Colors.black,
        fontWeight: FontWeight.w400);
    return Text(
      text,
      style: textStyle,
    );
  }
}
