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
  List<String> get results => projectInfo.results;

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
                    smallTextWidget('Project Name'),
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
                  smallTextWidget('Description'),
                  mediumTextWidget(projectDescription),
                  if (projectPeriod.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('Period'),
                    mediumTextWidget(projectPeriod),
                  ],
                  if (projectMembers.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('Member'),
                    mediumTextWidget(projectMembers!),
                  ],
                  if (contributionrate.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('Contribution'),
                    mediumTextWidget(contributionrate),
                  ],
                  if (detailedWorks.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('Work Detail'),
                    ...detailedWorks.map(
                      (e) => mediumTextWidget(e),
                    ),
                  ],
                  if (results.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('Achievement'),
                    ...results.map(
                      (e) => mediumTextWidget(e),
                    ),
                  ],
                  if (urls.isNotEmpty) ...[
                    const SizedBox(
                      height: 12.0,
                    ),
                    smallTextWidget('URL'),
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
                    smallTextWidget('Keyword'),
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
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
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
          fontWeight: FontWeight.w400,
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
          fontSize: 26.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
