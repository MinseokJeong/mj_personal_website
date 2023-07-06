import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/model/resume_info_manager.dart';
import 'package:mj_portfolio_web/page/good_developer_page.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/util/text_highligher.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/good_developer_widget.dart';
import 'package:mj_portfolio_web/widget/moving_around_tags_widget.dart';
import 'package:mj_portfolio_web/widget/skillset_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../model/route_name.dart' as rn;

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pictureRotateAnimationController;
  late Animation<double> _pictureRotateAniamtion;

  StreamController<Offset> _mousePointerPositionStreamController =
      StreamController<Offset>.broadcast();

  final _backgroundColor = HexColor("#1C1D20");

  //Below is resume related resource
  String _eamilAddress = '';
  String _githubUrl = '';
  String _instagramUrl = '';
  String _blogSpotUrl = '';
  String _phoneNumber = '';
  String _developerTitle = '';
  String _developerCategory = '';
  String _fullNameHangeul = '';
  String _fullNameEnglish = '';
  List<String> _whatIsGoodDeveloper = [];
  List<String> _aboutMe = [];

  //Skillset related... I think it woulbe better??
  List<String> _skillSetProgrammingLanguage = [];
  List<String> _skillSetFrontend = [];
  List<String> _skillSetEmbedded = [];
  List<String> _skillSetBackend = [];
  List<String> _skillSetToolingDevops = [];
  List<String> _skillSetEnvironment = [];
  List<String> _skillSetDB = [];
  List<String> _skillSetEtc = [];
  Set<String> _skillSetsMerge = {};

  @override
  void initState() {
    super.initState();

    _loadResumeInfo();

    _pictureRotateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    _pictureRotateAniamtion = Tween(begin: 0.0, end: 2 * math.pi)
        .animate(_pictureRotateAnimationController);
    _pictureRotateAnimationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();

    _pictureRotateAnimationController.dispose();
  }

  Future<void> _loadResumeInfo() async {
    final resumeInfoManager = ResumeInfoManager.getInstance();
    final resumeInfoJson = await resumeInfoManager.getResumeJson();
    final introduction = resumeInfoJson['introduction'] as Map<String, dynamic>;
    final fullNameHangeul = introduction['fullNameHangeul'] as String;
    final fullNameEnglish = introduction['fullNameEnglish'] as String;
    final mobile = introduction['mobile'] as String;
    final email = introduction['email'] as String;
    final website = introduction['website'] as String;
    final blogspot = introduction['blogspot'] as String;
    final instagram = introduction['instagram'] as String;
    final github = introduction['github'] as String;
    final devTitle = introduction['developerTitle'] as String;
    final devCategory = introduction['developerCategory'] as String;
    final aboutMe = List<String>.from(introduction['aboutMe']);

    final whatIsGoodDeveloper =
        List<String>.from(introduction['whatIsGoodDeveloper']);

    final skillSets = resumeInfoJson['skillSet'] as Map<String, dynamic>;
    final programmingLanguages =
        List<String>.from(skillSets['Programming Languages']);

    final frontEnd = List<String>.from(skillSets['Front-End']);
    final embedded = List<String>.from(skillSets['Embedded System / Firmware']);
    final backend = List<String>.from(skillSets['Back-End']);
    final toolingDevOps = List<String>.from(skillSets['Tooling / DevOps']);
    final environment = List<String>.from(skillSets['Environment']);
    final db = List<String>.from(skillSets['DB']);
    final etc = List<String>.from(skillSets['ETC']);

    setState(() {
      _eamilAddress = email;
      _githubUrl = github;
      _instagramUrl = instagram;
      _blogSpotUrl = blogspot;
      _phoneNumber = mobile;
      _developerTitle = devTitle;
      _developerCategory = devCategory;
      _fullNameHangeul = fullNameHangeul;
      _fullNameEnglish = fullNameEnglish;
      _aboutMe = aboutMe;

      _whatIsGoodDeveloper = whatIsGoodDeveloper;

      _skillSetProgrammingLanguage = programmingLanguages;
      _skillSetFrontend = frontEnd;
      _skillSetEmbedded = embedded;
      _skillSetBackend = backend;
      _skillSetToolingDevops = toolingDevOps;
      _skillSetEnvironment = environment;
      _skillSetDB = db;
      _skillSetEtc = etc;

      _skillSetsMerge = {
        ..._skillSetProgrammingLanguage,
        ..._skillSetFrontend,
        ..._skillSetEmbedded,
        ..._skillSetBackend,
        ..._skillSetToolingDevops,
        ..._skillSetEnvironment,
        ..._skillSetDB,
        ..._skillSetEtc,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize.getScreenWidth(context);
    if (screenSize >= ScreenType.laptop.width) {
      return Scaffold(
        backgroundColor: _backgroundColor,
        body: SingleChildScrollView(
          child: MouseRegion(
            onHover: (event) {
              _mousePointerPositionStreamController.sink
                  .add(event.localPosition);
            },
            child: Stack(
              children: [
                _getMainWidget(),
                _getMousePointerEffectWidget(),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: _backgroundColor,
        body: SingleChildScrollView(
          child: _getMainWidget(),
        ),
      );
    }
  }

  Widget _getMainWidget() {
    final screenHeight = ScreenSize.getScreenHeight(context);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopHeaderWidget(
            textColor: Colors.white,
            currentRoutePageName: rn.aboutPage,
          ),

          SizedBox(
            height: 120,
          ),
          _getProfileAndAboutMeDetailWidget(),
          SizedBox(
            height: 160.0,
          ),
          SizedBox(
            width: 1300,
            child: Stack(
              children: [
                SkillSetWidget(
                  skills: [
                    ('Programming Language', [..._skillSetProgrammingLanguage]),
                    ('Front-end', [..._skillSetFrontend]),
                    ('Embedded / Firmware', [..._skillSetEmbedded]),
                    ('Back-end', [..._skillSetBackend]),
                    ('Tooling / DevOps', [..._skillSetToolingDevops]),
                    ('Environment', [..._skillSetEnvironment]),
                    ('DB', [..._skillSetDB]),
                    ('ETC', [..._skillSetEtc]),
                  ],
                ),
              ],
            ),
          ),
          //_getGoodDeveloperExpandedPanelWidget(),
          //TODO: Should uncomment this

          SizedBox(
            height: 80,
          ),
          FooterWidget(
            highlightColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _getMousePointerEffectWidget() {
    final color = HexColor('#43953E');
    final double widgetSize = 240;
    return StreamBuilder<Offset>(
      stream: _mousePointerPositionStreamController.stream,
      builder: (bc, snapshot) {
        if (snapshot.hasData) {
          final offset = snapshot.data!;
          return Positioned(
            top: offset.dy - widgetSize / 2,
            left: offset.dx - widgetSize / 2,
            child: IgnorePointer(
              child: Container(
                width: widgetSize,
                height: widgetSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.normal,
                        color: color.withAlpha(24),
                        offset: Offset(0, 0),
                        blurRadius: widgetSize,
                        spreadRadius: widgetSize / 2),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _getAnimatedGooDeveloperWidget() {
    if (ScreenSize.isMobileScreenSize(context)) {
      return SizedBox(
        height: 180,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "'좋은 개발자' : ",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              if (_whatIsGoodDeveloper.isNotEmpty)
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ..._whatIsGoodDeveloper.map(
                      (e) => RotateAnimatedText(
                        e,
                        rotateOut: true,
                        duration: Duration(milliseconds: 2000),
                        transitionHeight: 20.0 * 10.0 / 3.0 * 2,
                        textStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 160,
        width: 1024,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "'좋은 개발자' : ",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Expanded(
                child: _whatIsGoodDeveloper.isEmpty
                    ? SizedBox.shrink()
                    : AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          ..._whatIsGoodDeveloper.map(
                            (e) => RotateAnimatedText(e,
                                rotateOut: true,
                                duration: Duration(milliseconds: 2000),
                                transitionHeight: 20.0 * 10.0 / 3.0 * 2,
                                textStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _getProfileAndAboutMeDetailWidget() {
    if (ScreenSize.isMobileScreenSize(context)) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _getProfileWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _getAboutMeDetailWidget(),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _pictureRotateAniamtion,
              builder: (bc, child) {
                return Transform.rotate(
                  angle: _pictureRotateAniamtion.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/minseokjeong_rotate_text.svg',
                width: 500,
                height: 500,
                color: Color.fromARGB(15, 255, 255, 255),
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 1300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _getProfileWidget(),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _getAboutMeDetailWidget(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _pictureRotateAniamtion,
              builder: (bc, child) {
                return Transform.rotate(
                  angle: _pictureRotateAniamtion.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/minseokjeong_rotate_text.svg',
                width: 500,
                height: 500,
                color: Color.fromARGB(15, 255, 255, 255),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _getActShowProveWidget() {
    final texts = [
      "DONT'T TALK JUST",
      "ACT",
      "DON'T SAY JUST",
      "SHOW",
      "DON'T PROMISE JUST",
      "PROVE"
    ];
    const smallTextStyle = TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
        height: 1.0,
        decoration: TextDecoration.lineThrough);
    const largeTextStyle = TextStyle(
        color: Colors.white,
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        height: 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          texts[0],
          style: smallTextStyle,
        ),
        Text(
          texts[1],
          style: largeTextStyle,
        ),
        Text(
          texts[2],
          style: smallTextStyle,
        ),
        Text(
          texts[3],
          style: largeTextStyle,
        ),
        Text(
          texts[4],
          style: smallTextStyle,
        ),
        Text(
          texts[5],
          style: largeTextStyle,
        ),
      ],
    );
  }

  Widget _getAboutMeDetailWidget() {
    final defaultTextStyle =
        TextStyle(color: Colors.grey, fontSize: 20, height: 1.4);
    final highlightTextStyle =
        TextStyle(color: Colors.white, fontSize: 20, height: 1.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._aboutMe.map((e) {
          final textHighlighter = TextHighlighter(e);
          final highlightTextModels = textHighlighter.getTexthighlightModel();
          return Column(
            children: [
              Text.rich(
                TextSpan(children: [
                  ...highlightTextModels.map((e) => TextSpan(
                      text: e.text,
                      style: (e.highlight)
                          ? highlightTextStyle
                          : defaultTextStyle))
                ]),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
        }),
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에있는 회사에서 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Android',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Windows',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' 개발자로 일을 하였고, 스타트업회사를 공동창업하며 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Andoid',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '/',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'iOS',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' 개발자로 일을 하였고, 방위산업체에서 근무하며 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Embedded System',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '/',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Firmware',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '/',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: 'Windows',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' 개발자로 일을 한 경험이 있습니다.',
        //         style: defaultTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 30.0,
        // ),
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: '다양한 플랫폼을 경험하면서 컴퓨터 및 프로그래밍에 대한 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '이해',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '가 넓고 깊으며 새로운',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '기술',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '을 습득하는 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '능력',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '이 뛰어납니다.',
        //         style: defaultTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 30.0,
        // ),
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: '위의 다양한 개발경험과 같이 가보지 않은 길로 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '도전',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '하는것을 즐기며 실패를 겁내지 않습니다.',
        //         style: defaultTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 30.0,
        // ),
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: '기업가정신',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: ' 을 추구하며 많은사람에게 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '가치',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '가 있고 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '도움',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '이되는 상품/서비스를 만드는것을 ',
        //         style: defaultTextStyle,
        //       ),
        //       TextSpan(
        //         text: '목표',
        //         style: highlightTextStyle,
        //       ),
        //       TextSpan(
        //         text: '로 합니다.',
        //         style: defaultTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 30.0,
        // ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "언제나 ",
              style: defaultTextStyle,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, rn.goodDeveloper);
              },
              label: Text(
                '좋은 개발자',
                style: highlightTextStyle,
              ),
              icon: Icon(
                Icons.thumb_up,
                color: Colors.white,
              ),
              //foregroundColor: Color(0xff4A5BE1),
              backgroundColor: Color(0xff4A5BE1),
            ),
            Text(
              "가 되기위해 최선을 다합니다.",
              style: defaultTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getProfileWidget() {
    const iconColor = Colors.grey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _fullNameEnglish,
          style: TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.0),
        ),
        Text(
          _fullNameHangeul,
          style: TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.0),
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          _developerTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          _developerCategory,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: _getActShowProveWidget(),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                if (_githubUrl.isNotEmpty) {
                  launchUrlString(_githubUrl);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: SvgPicture.asset(
                'assets/github_icon.svg',
                color: iconColor,
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_githubUrl.isNotEmpty) {
                  launchUrlString(_instagramUrl);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: SvgPicture.asset(
                'assets/instagram_icon.svg',
                color: iconColor,
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_eamilAddress.isNotEmpty) {
                  launchUrlString('mailto:${_eamilAddress}');
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Icon(
                Icons.email,
                color: iconColor,
                size: 30,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_phoneNumber.isNotEmpty) {
                  launchUrlString('tel:${_phoneNumber}');
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Icon(
                Icons.phone,
                color: iconColor,
                size: 30,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_blogSpotUrl.isNotEmpty) {
                  launchUrlString(_blogSpotUrl);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: SvgPicture.asset(
                'assets/blogspot_icon.svg',
                color: iconColor,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getGoodDeveloperExpandedPanelWidget() {
    if (_whatIsGoodDeveloper.isEmpty) {
      return SizedBox.shrink();
    }

    return ExpansionPanelList.radio(
      expandIconColor: Colors.white,
      children: [
        ExpansionPanelRadio(
          canTapOnHeader: true,
          backgroundColor: _backgroundColor,
          value: 'first',
          headerBuilder: (bc, _) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '좋은 개발자',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          body: Column(
            children: [
              for (int i = 0; i < _whatIsGoodDeveloper.length; ++i)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${(i + 1).toString()}. ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${_whatIsGoodDeveloper[i]}',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
