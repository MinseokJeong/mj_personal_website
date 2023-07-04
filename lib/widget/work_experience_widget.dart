import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';

import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';
import 'package:mj_portfolio_web/widget/url_link_button_widget.dart';
import 'package:mj_portfolio_web/widget/work_experience_panel_body_widget.dart';
import 'package:mj_portfolio_web/widget/work_experience_panel_header_widget.dart';

import '../model/size_variation.dart';
import 'project_widget.dart';

class WorkExperiencesWidget extends StatefulWidget {
  const WorkExperiencesWidget({super.key, required this.workExperiences});
  final List<WorkExperience> workExperiences;

  static const flexs = <int>[3, 1, 1, 2, 1];

  @override
  State<WorkExperiencesWidget> createState() => _WorkExperiencesWidgetState();
}

class _WorkExperiencesWidgetState extends State<WorkExperiencesWidget> {
  final _workExperienceAndExpandStates = <_WorkExperienceAndExpand>[];

  List<int> get flexs => WorkExperiencesWidget.flexs;

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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _topHeader(),
          ExpansionPanelList(
            elevation: 0,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _workExperienceAndExpandStates[panelIndex].isExpand =
                    !isExpanded;
              });
            },
            children: [
              ..._workExperienceAndExpandStates.map(
                (e) => ExpansionPanel(
                  isExpanded: e.isExpand,
                  canTapOnHeader: true,
                  headerBuilder: (bc, _) {
                    return WorkExperiencePanelHeaderWidget(
                        workExperience: e.workExperience);
                  },
                  body: WorkExperiencePanelBodyWidget(
                      workExperience: e.workExperience),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _topHeaderTextWidget(String text) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 18.0,
      whenTypeLaptopLarge: 18.0,
      whenTypeLaptop: 12.0,
      whenTypeTablet: 12.0,
      whenTypeMobileLarge: 10.0,
      whenTypeMobileMedium: 10.0,
      whenTypeMobileSmall: 10.0,
    );

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSizeVariation.getSizeWithContext(context),
        color: Color(0xffAFAFB0),
        fontWeight: FontWeight.w400,
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
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: _topHeaderTextWidget('Rank'),
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
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: 48.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkExperienceAndExpand {
  final WorkExperience workExperience;
  bool isExpand = false;

  _WorkExperienceAndExpand(this.workExperience, [this.isExpand = false]);
}
