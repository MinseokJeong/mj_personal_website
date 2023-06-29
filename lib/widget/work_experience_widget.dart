import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/widget/url_link_button_widget.dart';

import 'project_widget.dart';

class WorkExperiencesWidget extends StatefulWidget {
  const WorkExperiencesWidget({super.key, required this.workExperiences});
  final List<WorkExperience> workExperiences;

  @override
  State<WorkExperiencesWidget> createState() => _WorkExperiencesWidgetState();
}

class _WorkExperiencesWidgetState extends State<WorkExperiencesWidget> {
  final flexs = <int>[3, 1, 1, 2, 1];
  final _workExperienceAndExpandStates = <_WorkExperienceAndExpand>[];

  @override
  void initState() {
    super.initState();

    _updateWorkExperienceAndExpandStates();
  }

  void _updateWorkExperienceAndExpandStates() {
    _workExperienceAndExpandStates.clear();

    widget.workExperiences.forEach((element) {
      _workExperienceAndExpandStates
          .add(_WorkExperienceAndExpand(element, false));
    });

    setState(() {});
  }

  @override
  void didUpdateWidget(covariant WorkExperiencesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.hashCode != widget.hashCode) {
      _updateWorkExperienceAndExpandStates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _topHeader(),
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _workExperienceAndExpandStates[panelIndex].isExpand = !isExpanded;
            });
          },
          children: [
            ..._workExperienceAndExpandStates.map(
              (e) => _workExperienceWidget(e.workExperience, e.isExpand),
            )
          ],
        ),
      ],
    );
  }

  Widget _topHeaderTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        color: Color(0xffAFAFB0),
      ),
    );
  }

  Row _topHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[0],
          child: Center(
            child: _topHeaderTextWidget('Comapny'),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[1],
          child: _topHeaderTextWidget('Location'),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[2],
          child: _topHeaderTextWidget('Department/Rank'),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[3],
          child: _topHeaderTextWidget('Role'),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[4],
          child: _topHeaderTextWidget('Work Period'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            width: 48.0,
          ),
        ),
      ],
    );
  }

  ExpansionPanel _workExperienceWidget(
      WorkExperience workExperience, bool isExapnded) {
    final mediumTextStyle = TextStyle(
        fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.normal);

    final largeTextStyle = TextStyle(
        fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.normal);

    return ExpansionPanel(
      isExpanded: isExapnded,
      canTapOnHeader: true,
      headerBuilder: (bc, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
      },
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (workExperience.aboutCompany.isNotEmpty) ...[
                  _topHeaderTextWidget('회사소개'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      workExperience.aboutCompany,
                      style: TextStyle(
                        fontSize: 18.0,
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
                  _topHeaderTextWidget('관련링크'),
                  UrlLinkButtonWidget(
                      url: workExperience.companyWebsite,
                      text: workExperience.companyName)
                ],
              ],
            ),
            ...workExperience.projects.map(
              (e) => ProjectWidget(projectInfo: e),
            )
          ],
        ),
      ),
    );
  }
}

class _WorkExperienceAndExpand {
  final WorkExperience workExperience;
  bool isExpand = false;

  _WorkExperienceAndExpand(this.workExperience, [this.isExpand = false]);
}
