import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/interaction_common_button_widget.dart';
import 'package:mj_portfolio_web/widget/interaction_menu_button_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/project_information.dart';
import '../widget/work_experience_sub_project_widget.dart';

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
  final _textStyle2 = TextStyle(fontSize: 20.0, color: Colors.black);

  bool _expandedTest = false;
  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopHeaderWidget(
                textColor: Colors.black,
              ),
              const SizedBox(
                height: 120,
              ),
              //가운데 큰 헤더 여기에 알맞은 텍스트를 넣어야겟지?
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: windowSize.width * 0.16),
                child: Text(
                  'SHOW N PROVE\nMake it happen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _colorTextBlack,
                      fontSize: 88.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                ],
              ),
              SizedBox(
                height: 120,
              ),
              _workExperiencePlaceholder(),
              _workExperiences(),
              SizedBox(
                height: 30,
              ),
              _footerWidget()
            ],
          ),
        ),
      ),
    );
  }

  Container _footerWidget() {
    //"Loosely designed in Figma and coded in Visual Studio Code by yours truly. Built with Next.js and Tailwind CSS, deployed with Vercel. All text is set in the Inter typeface."
    return Container(
      width: double.infinity,
      height: 120.0,
      decoration: BoxDecoration(color: Colors.white, border: Border.all()),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This website design is too much inspired by ",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            TextButton(
                onPressed: () {
                  launchUrlString("https://dennissnellenberg.com/");
                },
                child: Text(
                  "Dennis Snellenberg",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero)),
          ],
        ),
      ),
    );
  }

  Widget _workExperiences() {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        print('idx:${panelIndex.toString()}, isExpanded:${isExpanded}');
        setState(() {
          _expandedTest = !isExpanded;
        });
      },
      children: [
        _workExperienceWidget(),
      ],
    );
  }

  ExpansionPanel _workExperienceWidget() {
    return ExpansionPanel(
      isExpanded: _expandedTest,
      canTapOnHeader: true,
      headerBuilder: (bc, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '(주)미래시스템',
                      style: _textStyle2,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '개발1부 SW팀',
                      style: _textStyle2,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '선임',
                      style: _textStyle2,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '• 임베디드/펌웨어/응용소프트웨어 개발',
                      style: _textStyle2,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '2019.02 ~ 2022.03',
                      style: _textStyle2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      /*
{
                    "projectName": "대함레이더 신호연동부 개발",
                    "projectDescription": "KDX-III Batch-II 함정 전투체계에 적용되는 대함레이더에서 이지스(Aegis)전투체계, 레이더전시기, GEDMS(Gigabit Ethernet Data Multiplex System)와 주고받는 연동신호를 변환하는 장치 개발 프로젝트",
                    "period": "2021년09월 ~ 2022년03월 (7개월)",
                    "keywords": [
                        "VxWorks",
                        "Wind River Workbench",
                        "Code Composer Studio(Texas Instruments)",
                        "Visual Studio",
                        "MFC",
                        "C++",
                        "C"
                    ],
                    "members": [
                        "소프트웨어 1명, 하드웨어 3명, 기계/기구 2명"
                    ],
                    "contribution": "기여도: 100%",
                    "role": [
                        "Single Board Computer(이하 SBC)에 VxWorks 이미지 포팅 및 개발 환경 구축",
                        "VME, UART, GPIO, Ethernet 통신 기능 구현",
                        "SLIP(Serial Line Internet Protocol) 통신 기능 구현.(RFC 1055)",
                        "네트워크 환경구축(VLAN, STP/RSTP, X-Ring Pro[Advantech])",
                        "시제품 전용 시험장치(이하 시험치구) 임베디드 SW개발(Arm Cortex-M4 based MCU)",
                        "시험치구 제어용 GUI SW개발(MFC)"
                    ],
                    "results": [],
                    "links": [
                        {
                            "textToDisplay": "대함레이더",
                            "url": "https://lignex1.com/web/kor/product/product.do?category=02&part=01&model=08#categoryMenu"
                        },
                        {
                            "textToDisplay": "함정전투체계",
                            "url": "https://www.hanwhasystems.com/kr/business/defense/naval/combat_index.do"
                        }
                    ]
                },
      */
      body: Container(
        child: Column(children: [
          WorkExperienceSubProjectWidget(
            projectInfo: ProjectInformation(
                projectName: "대함레이더 신호연동부 개발",
                projectDescription:
                    "KDX-III Batch-II 함정 전투체계에 적용되는 대함레이더에서 이지스(Aegis)전투체계, 레이더전시기, GEDMS(Gigabit Ethernet Data Multiplex System)와 주고받는 연동신호를 변환하는 장치 개발 프로젝트",
                projectPeriod: "2021년09월 ~ 2022년03월 (7개월)",
                projectMembers: "소프트웨어 1명, 하드웨어 3명, 기계/기구 2명",
                tags: [
                  "VxWorks",
                  "Wind River Workbench",
                  "Code Composer Studio(Texas Instruments)",
                  "Visual Studio",
                  "MFC",
                  "C++",
                  "C"
                ],
                detailedWorks: [
                  "Single Board Computer(이하 SBC)에 VxWorks 이미지 포팅 및 개발 환경 구축",
                  "VME, UART, GPIO, Ethernet 통신 기능 구현",
                  "SLIP(Serial Line Internet Protocol) 통신 기능 구현.(RFC 1055)",
                  "네트워크 환경구축(VLAN, STP/RSTP, X-Ring Pro[Advantech])",
                  "시제품 전용 시험장치(이하 시험치구) 임베디드 SW개발(Arm Cortex-M4 based MCU)",
                  "시험치구 제어용 GUI SW개발(MFC)"
                ],
                urls: [
                  (
                    url:
                        "https://lignex1.com/web/kor/product/product.do?category=02&part=01&model=08#categoryMenu",
                    text: "대함레이더"
                  ),
                  (
                    url:
                        "https://www.hanwhasystems.com/kr/business/defense/naval/combat_index.do",
                    text: "함정전투체계"
                  ),
                ]),
          ),
        ]),
      ),
    );
  }

  Row _workExperiencePlaceholder() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            'Company',
            style: _textStyle1,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            'Department',
            style: _textStyle1,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            'Rank',
            style: _textStyle1,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            'Role',
            style: _textStyle1,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            'Work Period',
            style: _textStyle1,
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
}
