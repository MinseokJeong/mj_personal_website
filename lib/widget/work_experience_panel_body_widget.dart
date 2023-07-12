import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';

import '../model/size_variation.dart';
import 'project_widget.dart';
import 'url_link_button_widget.dart';

class WorkExperiencePanelBodyWidget extends StatelessWidget {
  WorkExperiencePanelBodyWidget({super.key, required this.workExperience});
  WorkExperience workExperience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyInfoWidget(context),
        ...workExperience.projects.map(
          (e) => ProjectWidget(projectInfo: e),
        )
      ],
    );
  }

  Widget _topHeaderTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 14.0,
      whenTypeLaptopLarge: 14.0,
      whenTypeLaptop: 12.0,
      whenTypeTablet: 12.0,
      whenTypeMobileLarge: 10.0,
      whenTypeMobileMedium: 10.0,
      whenTypeMobileSmall: 10.0,
    );

    final textStyle = TextStyle(
      fontSize: fontSizeVariation.getSizeWithContext(context),
      color: const Color(0xffAFAFB0),
      fontWeight: FontWeight.w300,
    );
    return Text(
      text,
      style: textStyle,
    );
  }

  Widget _mediumTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 20,
      whenTypeLaptopLarge: 20.0,
      whenTypeLaptop: 20.0,
      whenTypeTablet: 18,
      whenTypeMobileLarge: 14.0,
      whenTypeMobileMedium: 14.0,
      whenTypeMobileSmall: 14.0,
    );

    final textStyle = TextStyle(
      fontSize: fontSizeVariation.getSizeWithContext(context),
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
    return Text(
      text,
      style: textStyle,
    );
  }

  Widget _companyInfoWidget(BuildContext context) {
    final screenWidth = ScreenSize.getScreenWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workExperience.website.isNotEmpty) ...[
                    _topHeaderTextWidget('URL', context),
                    UrlLinkButtonWidget(
                        url: workExperience.website,
                        text: workExperience.companyFullName),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                  if (workExperience.aboutCompany.isNotEmpty) ...[
                    _topHeaderTextWidget('About Company', context),
                    _mediumTextWidget(workExperience.aboutCompany, context),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                  if (workExperience.myRoleInCompany.isNotEmpty) ...[
                    _topHeaderTextWidget('My Role', context),
                    _mediumTextWidget(workExperience.myRoleInCompany, context),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
