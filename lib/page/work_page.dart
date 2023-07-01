import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mj_portfolio_web/model/work_experience.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/interaction_common_button_widget.dart';
import 'package:mj_portfolio_web/widget/interaction_menu_button_widget.dart';
import 'package:mj_portfolio_web/widget/side_project_experience_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'package:mj_portfolio_web/widget/work_experience_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/project_information.dart';
import '../widget/project_widget.dart';

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
    final windowSize = ScreenSize.getScreenSize(context);
    final ratio = ScreenTypeUtil.calculateRatioWithContext(context);

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
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: windowSize.width * 0.1),
                child: Text(
                  'Software Development Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _colorTextBlack,
                      fontSize: 88.0 * ratio,
                      fontWeight: FontWeight.w700),
                ),
              ),
              verticalSpace(60),
              Wrap(
                //mainAxisSize: MainAxisSize.min,
                runSpacing: 8,
                children: [
                  InteractionCommonButtonWidget(
                    text: 'All',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.white,
                    backgroundNormalColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InteractionCommonButtonWidget(
                    text: 'Flutter/Dart',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.black,
                    textFocusColor: Colors.white,
                    backgroundNormalColor: Colors.white,
                    backgroundFocusColor: Color(0xff4A5BE1),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InteractionCommonButtonWidget(
                    text: 'Mobile App',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.black,
                    textFocusColor: Colors.white,
                    backgroundNormalColor: Colors.white,
                    backgroundFocusColor: Color(0xff4A5BE1),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  InteractionCommonButtonWidget(
                    text: 'Web',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.black,
                    textFocusColor: Colors.white,
                    backgroundNormalColor: Colors.white,
                    backgroundFocusColor: Color(0xff4A5BE1),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  InteractionCommonButtonWidget(
                    text: 'Embedded/Firmware',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.black,
                    textFocusColor: Colors.white,
                    backgroundNormalColor: Colors.white,
                    backgroundFocusColor: Color(0xff4A5BE1),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  InteractionCommonButtonWidget(
                    text: 'ETC',
                    badge: '32',
                    onPressed: () {},
                    textNormalColor: Colors.black,
                    textFocusColor: Colors.white,
                    backgroundNormalColor: Colors.white,
                    backgroundFocusColor: Color(0xff4A5BE1),
                  ),
                ],
              ),
              verticalSpace(60),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAIN',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 32 * ratio,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: WorkExperiencesWidget(workExperiences: _workExperiences),
              ),
              verticalSpace(60),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SIDE / ETC',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 32 * ratio,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget verticalSpace(double verticalSpace) {
    return SizedBox(
      height: verticalSpace,
    );
  }
}
