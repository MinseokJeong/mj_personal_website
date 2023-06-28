import 'package:flutter/material.dart';

import '../model/project_information.dart';
import 'tag_widget.dart';
import 'url_link_button_widget.dart';

class WorkExperienceSubProjectWidget extends StatelessWidget {
  WorkExperienceSubProjectWidget({super.key, required this.projectInfo});
  final ProjectInformation projectInfo;

  String get projectName => projectInfo.projectName;
  String get projectDescription => projectInfo.projectDescription;
  String get projectPeriod => projectInfo.projectPeriod;
  String get projectMembers => projectInfo.projectMembers;
  String get contributionrate => projectInfo.contributionrate;
  List<String> get detailedWorks => projectInfo.detailedWorks;
  List<String> get tags => projectInfo.tags;
  List<({String url, String text})> get urls => projectInfo.urls;

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
              child: _projectNameWidget(),
            ),
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._projectDescriptionWidget(),
                  ..._projectPeriodWidget(),
                  ..._projectMembersWidget(),
                  ..._projectContributionWidget(),
                  ..._projectDetailedWorksWidget(),
                  ..._projectDetailedWorksWidget(),
                  ..._projectLinksWidget(),
                  ..._projectTagsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '프로젝트명',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          projectName,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  List<Widget> _projectDescriptionWidget() {
    return [
      Text(
        '프로젝트 소개',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        projectDescription,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      )
    ];
  }

  List<Widget> _projectPeriodWidget() {
    if (projectPeriod.isEmpty) {
      return [];
    }

    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '프로젝트기간',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        projectPeriod!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  List<Widget> _projectMembersWidget() {
    if (projectMembers.isEmpty) {
      return [];
    }
    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '멤버구성',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        projectMembers!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  List<Widget> _projectContributionWidget() {
    if (contributionrate.isEmpty) {
      return [];
    }
    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '기여도',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        contributionrate!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  List<Widget> _projectDetailedWorksWidget() {
    if (detailedWorks.isEmpty) {
      return [];
    }

    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '상세업무',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      ...detailedWorks!.map(
        (e) => Text(
          e,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ];
  }

  List<Widget> _projectLinksWidget() {
    if (urls.isEmpty) {
      return [];
    }

    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '관련링크',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Wrap(
        children: [
          ...urls!.map(
            (e) => UrlLinkButtonWidget(url: e.url, text: e.text),
          )
        ],
      ),
    ];
  }

  List<Widget> _projectTagsWidget() {
    if (tags.isEmpty) {
      return [];
    }

    return [
      SizedBox(
        height: 12.0,
      ),
      Text(
        '키워드',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...tags!.map(
            (e) => TagWidget(tag: e),
          )
        ],
      ),
    ];
  }
}
