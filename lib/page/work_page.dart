import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/interaction_common_button_widget.dart';
import 'package:mj_portfolio_web/widget/side_project_experience_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'package:mj_portfolio_web/widget/work_experience_widget.dart';
import '../model/project_information.dart';

//TODO: WORK PAGE 의 처음 Keywords 버튼들을 어떻게 관리할지를 생각해봐야함.
class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final _colorBackground = const Color(0xFFFFFFFF);
  final _colorTextBlack = const Color(0xff1C1D20);
  final _colorTextGrey = const Color(0xffAFAFB0);
  final _colorButtonBorder = const Color(0xffAFAFB0);
  final _colorButtonColorWhite = const Color(0xFFFFFFFF);
  final _colorButtonColorBlack = const Color(0xff1C1D20);

  final _textStyle1 = TextStyle(
    fontSize: 14.0,
    color: Color(0xffAFAFB0),
  );

  List<WorkExperience> _workExperiences = [];
  List<ProjectInformation> _sideProjectInformation = [];

  var sortingButtonInfoMap = <String, Map<String, dynamic>>{
    'All': {
      'badge': 32,
    },
    'Flutter/Dart': {
      'badge': 16,
    },
    'Mobile App': {
      'badge': 16,
    },
    'Web': {
      'badge': 16,
    },
    'Embedded/Firmware': {
      'badge': 16,
    },
    'Etc': {
      'badge': 16,
    },
  };

  String _selectedSortedButton = 'All';

  @override
  void initState() {
    super.initState();

    _loadWorkExperience();
  }

  Future<void> _loadWorkExperience() async {
    final resumeJsonString =
        await rootBundle.loadString('assets/resume_info.json', cache: false);
    final resumeJson = jsonDecode(resumeJsonString) as Map<String, dynamic>;
    final workExperiencesJson = resumeJson['workExperiences'] as List<dynamic>;
    final sideProjectsJson = resumeJson['sideProjects'] as List<dynamic>;

    List<WorkExperience> workExperiences = [];
    for (var workExperienceJson in workExperiencesJson) {
      final workExperience = WorkExperience.fromJson(workExperienceJson);
      workExperiences.add(workExperience);
    }

    List<ProjectInformation> sideProjects = [];
    for (var sideprojectJson in sideProjectsJson) {
      final sideproject = ProjectInformation.fromJson(sideprojectJson);
      sideProjects.add(sideproject);
    }
    setState(() {
      _workExperiences = workExperiences;
      _sideProjectInformation = sideProjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ratio = ScreenTypeExtension.calculateRatioWithContext(context);

    return Scaffold(
      backgroundColor: _colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopHeaderWidget(
                textColor: Colors.black,
              ),
              verticalSpace(120),
              //가운데 큰 헤더 여기에 알맞은 텍스트를 넣어야겟지?
              Text(
                'Software Development Experience',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _colorTextBlack,
                    fontSize: 88.0 * ratio,
                    fontWeight: FontWeight.w700),
              ),
              verticalSpace(60),
              _sortingButtonsWidget(),
              verticalSpace(60),
              _centerTextWithHorizontalBarWidget('Main'),
              verticalSpace(30),
              WorkExperiencesWidget(workExperiences: _workExperiences),
              verticalSpace(60),
              _centerTextWithHorizontalBarWidget('Other / Etc'),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SideProjectExperiencesWidget(
                    sideProjectInformations: _sideProjectInformation),
              ),
              verticalSpace(30),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortingButtonsWidget() {
    const selectedTextNormalColor = Colors.white;
    const selectedBackgroundColor = Colors.black;
    const unSelectedTextNormalColor = Colors.black;
    const unSelectedTextFocusColor = Colors.white;
    const unSelectedBackgroundNormalColor = Colors.white;
    const unSelectedBackgroundFocusColor = Color(0xff4A5BE1);

    return Wrap(
      //mainAxisSize: MainAxisSize.min,
      spacing: 16,
      runSpacing: 8,
      children: [
        ...sortingButtonInfoMap.map(
          (key, value) {
            final badge = value['badge'] as int;
            final selected = (_selectedSortedButton.compareTo(key) == 0);
            return MapEntry(
              key,
              InteractionCommonButtonWidget(
                text: key,
                badge: badge.toString(),
                onPressed: () {
                  setState(() {
                    _selectedSortedButton = key;
                  });
                },
                textNormalColor: (selected)
                    ? selectedTextNormalColor
                    : unSelectedTextNormalColor,
                textFocusColor: (selected) ? null : unSelectedTextFocusColor,
                backgroundNormalColor: (selected)
                    ? selectedBackgroundColor
                    : unSelectedBackgroundNormalColor,
                backgroundFocusColor:
                    (selected) ? null : unSelectedBackgroundFocusColor,
              ),
            );
          },
        ).values,
      ],
    );
  }

  Widget verticalSpace(double verticalSpace) {
    return SizedBox(
      height: verticalSpace,
    );
  }

  Widget _centerTextWithHorizontalBarWidget(String text) {
    return Row(
      children: [
        Flexible(
          child: Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
