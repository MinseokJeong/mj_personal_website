import 'package:flutter/material.dart';

import '../model/project_information.dart';
import 'tag_widget.dart';
import 'url_link_button_widget.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key, required this.projectInfo});
  final ProjectInformation projectInfo;

  String get projectName => projectInfo.projectName;
  String get projectDescription => projectInfo.projectDescription;
  String get projectPeriod => projectInfo.projectPeriod;
  String get projectMembers => projectInfo.projectMembers;
  String get contributionrate => projectInfo.contributionrate;
  List<String> get detailedWorks => projectInfo.detailedWorks;
  List<String> get tags => projectInfo.tags;
  List<({String url, String text})> get urls => projectInfo.urls;

  final _textIndentPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smallTextWidget('프로젝트명'),
                    largeTextWidget(projectName),
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
                  smallTextWidget('프로젝트 소개'),
                  mediumTextWidget(projectDescription),
                  if (projectPeriod.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('프로젝트기간'),
                    mediumTextWidget(projectPeriod),
                  ],
                  if (projectMembers.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('멤버구성'),
                    mediumTextWidget(projectMembers!),
                  ],
                  if (contributionrate.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('기여도'),
                    mediumTextWidget(contributionrate),
                  ],
                  if (detailedWorks.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('상세업무'),
                    ...detailedWorks.map(
                      (e) => mediumTextWidget(e),
                    ),
                  ],
                  if (urls.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('관련링크'),
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
                    smallTextWidget('키워드'),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ...tags.map(
                          (e) => TagWidget(tag: e),
                        )
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smallTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget mediumTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget largeTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
