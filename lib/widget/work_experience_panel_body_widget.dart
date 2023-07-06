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
    if (!ScreenSize.isMobileScreenSize(context)) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: (workExperience.aboutCompany.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topHeaderTextWidget('About Company', context),
                          _mediumTextWidget(
                              workExperience.aboutCompany, context),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: workExperience.companyWebsite.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _topHeaderTextWidget('URL', context),
                          UrlLinkButtonWidget(
                              url: workExperience.companyWebsite,
                              text: workExperience.companyName),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          if (workExperience.aboutCompany.isNotEmpty) ...[
            _topHeaderTextWidget('About Company', context),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _mediumTextWidget(workExperience.aboutCompany, context),
            ),
          ],
          if (workExperience.companyWebsite.isNotEmpty) ...[
            const SizedBox(
              height: 12.0,
            ),
            _topHeaderTextWidget('URL', context),
            UrlLinkButtonWidget(
                url: workExperience.companyWebsite,
                text: workExperience.companyName)
          ],
        ],
      );
    }
  }
}
