import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';

import '../model/project_information.dart';
import '../model/size_variation.dart';
import 'tag_widget.dart';
import 'url_link_button_widget.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key, required this.projectInfo});
  final ProjectInformation projectInfo;

  String get projectName => projectInfo.projectName;
  String get projectDescription => projectInfo.projectDescription;
  String get projectPeriod => projectInfo.projectPeriod;
  String get projectMembers => projectInfo.members;
  String get contributionrate => projectInfo.contributionrate;
  List<String> get detailedWorks => projectInfo.workDetail;
  List<String> get tags => projectInfo.keywords;
  List<({String url, String text})> get urls => projectInfo.links;
  List<String> get results => projectInfo.results;

  final _textIndentPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _smallTextWidget('Project Name', context),
                    _largeTextWidget(projectName, context),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _smallTextWidget('Description', context),
                  _mediumTextWidget(projectDescription, context),
                  if (projectPeriod.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Period', context),
                    _mediumTextWidget(projectPeriod, context),
                  ],
                  if (projectMembers.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Member', context),
                    _mediumTextWidget(projectMembers, context),
                  ],
                  if (contributionrate.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Contribution', context),
                    _mediumTextWidget(contributionrate, context),
                  ],
                  if (detailedWorks.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Work Detail', context),
                    ...detailedWorks.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: _mediumTextWidget(e, context),
                      ),
                    ),
                  ],
                  if (results.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Achievement', context),
                    ...results.map(
                      (e) => _mediumTextWidget(e, context),
                    ),
                  ],
                  if (urls.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('URL', context),
                    Wrap(
                      children: [
                        ...urls.map(
                          (e) => UrlLinkButtonWidget(url: e.url, text: e.text),
                        )
                      ],
                    ),
                  ],
                  if (tags.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    _smallTextWidget('Keyword', context),
                    const SizedBox(
                      height: 4.0,
                    ),
                    _getKeywordsWidgets(context),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Wrap _getKeywordsWidgets(BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 16.0,
      whenTypeLaptopLarge: 16.0,
      whenTypeLaptop: 14.0,
      whenTypeTablet: 14.0,
      whenTypeMobileLarge: 12.0,
      whenTypeMobileMedium: 12.0,
      whenTypeMobileSmall: 12.0,
    );

    final paddingSizeVariation = SizeVariation(
      whenType4K: 8.0,
      whenTypeLaptopLarge: 8.0,
      whenTypeLaptop: 8.0,
      whenTypeTablet: 6.0,
      whenTypeMobileLarge: 4.0,
      whenTypeMobileMedium: 4.0,
      whenTypeMobileSmall: 4.0,
    );

    final padding =
        EdgeInsets.all(paddingSizeVariation.getSizeWithContext(context));
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ...tags.map(
          (e) => TagWidget(
            tag: e,
            fontSize: fontSizeVariation.getSizeWithContext(context),
            padding: padding,
          ),
        )
      ],
    );
  }

  Widget _largeTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 26.0,
      whenTypeLaptopLarge: 26.0,
      whenTypeLaptop: 20.0,
      whenTypeTablet: 20.0,
      whenTypeMobileLarge: 16.0,
      whenTypeMobileMedium: 16.0,
      whenTypeMobileSmall: 16.0,
    );

    final textStyle = TextStyle(
      fontSize: fontSizeVariation.getSizeWithContext(context),
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

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
      fontWeight: FontWeight.w500,
    );

    return Text(
      text,
      style: textStyle,
    );
  }

  Widget _smallTextWidget(String text, BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 14.0,
      whenTypeLaptopLarge: 14.0,
      whenTypeLaptop: 14.0,
      whenTypeTablet: 14.0,
      whenTypeMobileLarge: 10.0,
      whenTypeMobileMedium: 10.0,
      whenTypeMobileSmall: 10.0,
    );

    final textStyle = TextStyle(
      fontSize: fontSizeVariation.getSizeWithContext(context),
      color: Colors.grey,
      fontWeight: FontWeight.w400,
    );
    return Text(
      text,
      style: textStyle,
    );
  }
}
