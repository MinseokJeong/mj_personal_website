import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';

import 'work_experience_sub_project_widget.dart';

class WorkExperiencesWidget extends StatefulWidget {
  const WorkExperiencesWidget({super.key, required this.workExperiences});
  final List<WorkExperience> workExperiences;

  @override
  State<WorkExperiencesWidget> createState() => _WorkExperiencesWidgetState();
}

class _WorkExperiencesWidgetState extends State<WorkExperiencesWidget> {
  final flexs = <int>[3, 1, 1, 2, 1];
  final _workExperienceAndExpandStates = <_WorkExperienceAndExpand>[];

  final topHeaderTextStyle = TextStyle(
    fontSize: 14.0,
    color: Color(0xffAFAFB0),
  );

  @override
  void initState() {
    super.initState();

    _updateWorkExperienceAndExpandStates();
  }

  void _updateWorkExperienceAndExpandStates() {
    widget.workExperiences.forEach((element) {
      _workExperienceAndExpandStates
          .add(_WorkExperienceAndExpand(element, true));
    });

    setState(() {});
  }

  @override
  void didUpdateWidget(covariant WorkExperiencesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateWorkExperienceAndExpandStates();
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

  Row _topHeader() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[0],
          child: Center(
            child: Text(
              'Company',
              style: topHeaderTextStyle,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[1],
          child: Text(
            'Location',
            style: topHeaderTextStyle,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[2],
          child: Text(
            'Department/Rank',
            style: topHeaderTextStyle,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[3],
          child: Text(
            'Role',
            style: topHeaderTextStyle,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: flexs[4],
          child: Text(
            'Work Period',
            style: topHeaderTextStyle,
          ),
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
        fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w400);

    final largeTextStyle = TextStyle(
        fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w400);

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
        child: Column(children: [
          ...workExperience.projects.map(
            (e) => WorkExperienceSubProjectWidget(projectInfo: e),
          )
        ]),
      ),
    );
  }
}

class _WorkExperienceAndExpand {
  final WorkExperience workExperience;
  bool isExpand = false;

  _WorkExperienceAndExpand(this.workExperience, [this.isExpand = false]);
}
