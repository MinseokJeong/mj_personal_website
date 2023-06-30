import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/project_information.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/widget/url_link_button_widget.dart';

import 'project_widget.dart';

class SideProjectExperiencesWidget extends StatefulWidget {
  const SideProjectExperiencesWidget(
      {super.key, required this.sideProjectInformations});
  final List<ProjectInformation> sideProjectInformations;

  @override
  State<SideProjectExperiencesWidget> createState() =>
      _SideProjectExperiencesWidgetState();
}

class _SideProjectExperiencesWidgetState
    extends State<SideProjectExperiencesWidget> {
  final flexs = <int>[3, 4, 1];
  final _sideProjectExperienceAndExpandStates =
      <_SideProjectExperienceAndExpand>[];

  @override
  void initState() {
    super.initState();

    _updateWorkExperienceAndExpandStates();
  }

  void _updateWorkExperienceAndExpandStates() {
    _sideProjectExperienceAndExpandStates.clear();

    widget.sideProjectInformations.forEach((element) {
      _sideProjectExperienceAndExpandStates
          .add(_SideProjectExperienceAndExpand(element, false));
    });

    setState(() {});
  }

  @override
  void didUpdateWidget(covariant SideProjectExperiencesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.hashCode != widget.hashCode) {
      _updateWorkExperienceAndExpandStates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _topHeader(),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _sideProjectExperienceAndExpandStates[panelIndex].isExpand =
                    !isExpanded;
              });
            },
            children: [
              ..._sideProjectExperienceAndExpandStates.map(
                (e) => _sideProjectExperienceWidget(
                    e.projectInformation, e.isExpand),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _topHeaderTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: Color(0xffAFAFB0),
        fontWeight: FontWeight.w400,
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

  Widget _topHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: flexs[0],
            child: Center(
              child: _topHeaderTextWidget('Project Name'),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: flexs[1],
            child: _topHeaderTextWidget('Description'),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: flexs[2],
            child: _topHeaderTextWidget('Work Period'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: 48.0,
            ),
          ),
        ],
      ),
    );
  }

  ExpansionPanel _sideProjectExperienceWidget(
      ProjectInformation projectInformation, bool isExapnded) {
    const mediumTextStyle = TextStyle(
        fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w400);

    const largeTextStyle = TextStyle(
        fontSize: 32.0, color: Colors.black, fontWeight: FontWeight.w500);

    return ExpansionPanel(
      isExpanded: isExapnded,
      canTapOnHeader: true,
      headerBuilder: (bc, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: flexs[0],
                child: Center(
                  child: Text(
                    projectInformation.projectName,
                    style: largeTextStyle,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: flexs[1],
                child: Text(
                  projectInformation.projectDescription,
                  style: mediumTextStyle,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: flexs[2],
                child: Text(
                  projectInformation.projectPeriod,
                  style: mediumTextStyle,
                ),
              ),
            ],
          ),
        );
      },
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectWidget(
              projectInfo: projectInformation,
            ),
          ],
        ),
      ),
    );
  }
}

class _SideProjectExperienceAndExpand {
  final ProjectInformation projectInformation;
  bool isExpand = false;

  _SideProjectExperienceAndExpand(this.projectInformation,
      [this.isExpand = false]);
}
