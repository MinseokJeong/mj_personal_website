import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mj_portfolio_web/model/resume_info_manager.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/interaction_common_button_widget.dart';
import 'package:mj_portfolio_web/widget/other_project_experience_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'package:mj_portfolio_web/widget/work_experience_widget.dart';
import '../model/project_information.dart';
import '../model/route_name.dart' as rn;

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
  List<WorkExperience> _filteredWorkExperiences = [];
  List<ProjectInformation> _filteredSideProjectInformation = [];

  var filteringButtonInfoMap = <String, int>{
    'All': 0,
    // 'Flutter/Dart':3,
    // 'Mobile App': 2,
    // 'Web': 2,
    // 'Embedded/Firmware':2,
    'Etc': 0,
  };

  String _selectedSortedButton = 'All';

  @override
  void initState() {
    super.initState();

    _loadWorkExperience();
  }

  void _updateFilteringButtonInfoMap() {
    Map<String, int> catergoryCountMap = {
      'All': 0,
      'Etc': 0,
    };

    for (final workExperience in _workExperiences) {
      for (final project in workExperience.projects) {
        catergoryCountMap.update(
          'All',
          (value) => value + 1,
          ifAbsent: () => 1,
        );
        final category = project.category;
        for (final categoryItem in category) {
          catergoryCountMap.update(
            categoryItem,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }
        if (category.isEmpty) {
          catergoryCountMap.update(
            'Etc',
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }
      }
    }

    for (final project in _sideProjectInformation) {
      catergoryCountMap.update(
        'All',
        (value) => value + 1,
        ifAbsent: () => 1,
      );
      final category = project.category;
      for (final categoryItem in category) {
        catergoryCountMap.update(
          categoryItem,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
      if (category.isEmpty) {
        catergoryCountMap.update(
          'Etc',
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }

    filteringButtonInfoMap = catergoryCountMap;
  }

  void _filteringWithKeyword(String keyword) {
    final filteredWorkExperiences = <WorkExperience>[];
    final filteredSideProjects = <ProjectInformation>[];
    if (keyword == 'All') {
      filteredWorkExperiences.addAll(_workExperiences);
      filteredSideProjects.addAll(_sideProjectInformation);
    } else if (keyword == 'Etc') {
      final filteringButtonInfoMapKey = filteringButtonInfoMap.keys.toList();
      filteringButtonInfoMapKey.remove('All');
      filteringButtonInfoMapKey.remove('Etc');

      for (final workExperience in _workExperiences) {
        final newWorkExperience = WorkExperience(
            companyName: workExperience.companyName,
            location: workExperience.location,
            rank: workExperience.rank,
            mainRole: workExperience.mainRole,
            workPeriod: workExperience.workPeriod,
            projects: [],
            companyWebsite: workExperience.companyWebsite,
            aboutCompany: workExperience.aboutCompany);

        for (final project in workExperience.projects) {
          bool hasKeyWord = false;
          for (final filteringKeyword in filteringButtonInfoMapKey) {
            if (project.category.contains(filteringKeyword)) {
              hasKeyWord = true;

              break;
            }
          }
          if (!hasKeyWord) {
            newWorkExperience.projects.add(project);
          }
        }
        if (newWorkExperience.projects.isNotEmpty) {
          filteredWorkExperiences.add(newWorkExperience);
        }
      }

      for (final project in _sideProjectInformation) {
        bool hasKeyworkd = false;
        for (final filteringKeyword in filteringButtonInfoMapKey) {
          if (project.category.contains(filteringKeyword)) {
            hasKeyworkd = true;

            break;
          }
        }
        if (!hasKeyworkd) {
          filteredSideProjects.add(project);
        }
      }
    } else {
      for (final workExperience in _workExperiences) {
        bool hasKeyword = false;
        final newWorkExperience = WorkExperience(
            companyName: workExperience.companyName,
            location: workExperience.location,
            rank: workExperience.rank,
            mainRole: workExperience.mainRole,
            workPeriod: workExperience.workPeriod,
            projects: [],
            companyWebsite: workExperience.companyWebsite,
            aboutCompany: workExperience.aboutCompany);

        for (final project in workExperience.projects) {
          if (project.category.contains(keyword)) {
            newWorkExperience.projects.add(project);
            hasKeyword = true;
          }
        }

        if (hasKeyword) {
          filteredWorkExperiences.add(newWorkExperience);
        }
      }

      for (final project in _sideProjectInformation) {
        if (project.category.contains(keyword)) {
          filteredSideProjects.add(project);
        }
      }
    }

    setState(() {
      _filteredWorkExperiences = filteredWorkExperiences;
      _filteredSideProjectInformation = filteredSideProjects;
    });
  }

  Future<void> _loadWorkExperience() async {
    final resumeInfoManger = ResumeInfoManager.getInstance();
    final resumeJson = await resumeInfoManger.getResumeJson();

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

      _filteredWorkExperiences.addAll(_workExperiences);
      _filteredSideProjectInformation.addAll(_sideProjectInformation);

      _updateFilteringButtonInfoMap();
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
                currentRoutePageName: rn.workPage,
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
              WorkExperiencesWidget(workExperiences: _filteredWorkExperiences),
              verticalSpace(60),
              _centerTextWithHorizontalBarWidget('Other / Etc'),
              OtherProjectExperiencesWidget(
                  sideProjectInformations: _filteredSideProjectInformation),
              verticalSpace(30),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortingButtonsWidget() {
    final filteringButtonInfoList = filteringButtonInfoMap.keys.toList();
    filteringButtonInfoList.remove('All');
    filteringButtonInfoList.remove('Etc');
    final allBadge = filteringButtonInfoMap['All']!;
    final etcBadge = filteringButtonInfoMap['Etc']!;
    final selectedAll = (_selectedSortedButton.compareTo('All') == 0);
    final selectedEtc = (_selectedSortedButton.compareTo('Etc') == 0);

    return Wrap(
      //mainAxisSize: MainAxisSize.min,
      spacing: 16,
      runSpacing: 8,
      children: [
        _filteringButtonWidget('All', allBadge, selectedAll),
        ...filteringButtonInfoList.map((key) {
          final badge = filteringButtonInfoMap[key]!;
          final selected = (_selectedSortedButton.compareTo(key) == 0);
          return _filteringButtonWidget(key, badge, selected);
        }),
        _filteringButtonWidget('Etc', etcBadge, selectedEtc),
      ],
    );
  }

  Widget _filteringButtonWidget(String key, int badge, bool selected) {
    const selectedTextNormalColor = Colors.white;
    const selectedBackgroundColor = Colors.black;
    const unSelectedTextNormalColor = Colors.black;
    const unSelectedTextFocusColor = Colors.white;
    const unSelectedBackgroundNormalColor = Colors.white;
    const unSelectedBackgroundFocusColor = Color(0xff4A5BE1);
    return InteractionCommonButtonWidget(
      text: key,
      badge: badge.toString(),
      onPressed: () {
        setState(() {
          _selectedSortedButton = key;
          _filteringWithKeyword(key);
        });
      },
      textNormalColor:
          (selected) ? selectedTextNormalColor : unSelectedTextNormalColor,
      textFocusColor: (selected) ? null : unSelectedTextFocusColor,
      backgroundNormalColor: (selected)
          ? selectedBackgroundColor
          : unSelectedBackgroundNormalColor,
      backgroundFocusColor: (selected) ? null : unSelectedBackgroundFocusColor,
    );
  }

  Widget verticalSpace(double verticalSpace) {
    return SizedBox(
      height: verticalSpace,
    );
  }

  Widget _centerTextWithHorizontalBarWidget(String text) {
    final ratio = ScreenTypeExtension.calculateRatioWithContext(context);
    double fontSize = 32.0 * ratio;
    if (fontSize < 14.0) {
      fontSize = 14.0;
    }
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
                fontSize: fontSize,
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
