import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';

import 'project_widget.dart';
import 'url_link_button_widget.dart';

class WorkExperiencePanelBodyWidget extends StatelessWidget {
  WorkExperiencePanelBodyWidget({super.key, required this.workExperience});
  WorkExperience workExperience;

  @override
  Widget build(BuildContext context) {
    /*
    if (ScreenSize.isTabletScreenSize(context)) {
      
    } else if (ScreenSize.isMobileScreenSize(context)) {
    } else {}
*/
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (workExperience.aboutCompany.isNotEmpty) ...[
                  _greySmallTextWidget('About Company'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      workExperience.aboutCompany,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        // fontWeight: FontWeight.w100,
                        // fontFamily: 'NotoSansKorean',
                      ),
                    ),
                  ),
                ],
                if (workExperience.companyWebsite.isNotEmpty) ...[
                  SizedBox(
                    height: 12.0,
                  ),
                  _greySmallTextWidget('URL'),
                  UrlLinkButtonWidget(
                      url: workExperience.companyWebsite,
                      text: workExperience.companyName)
                ],
              ],
            ),
          ),
          ...workExperience.projects.map(
            (e) => ProjectWidget(projectInfo: e),
          )
        ],
      ),
    );
  }

  Widget _greySmallTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        color: Color(0xffAFAFB0),
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
