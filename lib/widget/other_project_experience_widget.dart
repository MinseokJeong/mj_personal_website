import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/project_information.dart';

import '../util/screen_size.dart';
import 'other_project_experience_panel_header_widget.dart';
import 'project_widget.dart';

class OtherProjectExperiencesWidget extends StatefulWidget {
  const OtherProjectExperiencesWidget(
      {super.key, required this.sideProjectInformations});
  final List<ProjectInformation> sideProjectInformations;
  static const flexs = <int>[3, 4, 1];
  @override
  State<OtherProjectExperiencesWidget> createState() =>
      _OtherProjectExperiencesWidgetState();
}

class _OtherProjectExperiencesWidgetState
    extends State<OtherProjectExperiencesWidget> {
  List<int> get flexs => OtherProjectExperiencesWidget.flexs;
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
  void didUpdateWidget(covariant OtherProjectExperiencesWidget oldWidget) {
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
                (e) => ExpansionPanel(
                  isExpanded: e.isExpand,
                  canTapOnHeader: true,
                  headerBuilder: (bc, _) {
                    return OtherProjectExperiencePanelHeaderWidget(
                        projectInformation: e.projectInformation);
                  },
                  body: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProjectWidget(
                          projectInfo: e.projectInformation,
                        ),
                      ],
                    ),
                  ),
                ),
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
    if (ScreenSize.isTabletScreenSize(context) ||
        ScreenSize.isMobileScreenSize(context)) {
      return SizedBox.shrink();
    }

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
}

class _SideProjectExperienceAndExpand {
  final ProjectInformation projectInformation;
  bool isExpand = false;

  _SideProjectExperienceAndExpand(this.projectInformation,
      [this.isExpand = false]);
}
