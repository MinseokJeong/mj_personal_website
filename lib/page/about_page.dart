import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/model/resume_info_manager.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/util/text_highligher.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/skillset_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'dart:math' as math;
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

  final StreamController<Offset> _mousePointerPositionStreamController =
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
      duration: const Duration(seconds: 30),
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

      //_aboutMe = aboutMe;
      //TODO: DELETE BELOW CODE
      _aboutMe = [
        "대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에 있는 회사에서 <Kickstarter> 프로젝트에 참여하면서 <Android> 앱을 개발하였고, 그 후 한국으로 돌아와 캐나다 Vancouver에 있는 3D 스캐너 회사와 재택근무를 하며 <Windows Desktop> 프로그램을 개발하였고, 지인과 둘이서 스타트업 회사를 창업하여 <Android/iOS> 개발자로 일을 하였고 <사회적 기업 국가지원 사업에 선정>되고 프로젝트 관련 <특허 등록>경험이 있으며 창업 경진대회에서 <창업 아이디어 부문 대상 수상>한 경험이 있고, 방위산업체에서 근무하며 군에 납품하는 장비 및 프로그램을 개발하며 <Embedded System/Firmware>, <Windows Desktop> 개발자로 일을 하였습니다.",
        "<Mobile App> 및 <Desktop App> 그리고 <Embedded System/Firmware>와 같이 다양한 실무 경험과 <Web> 관련 사이드 프로젝트 경험 및 이런 <경험>을 바탕으로 전반적인 컴퓨터 및 <프로그래밍에 대한 이해>가 넓으며 새로운 기술을 <습득하는 능력>이 뛰어납니다.",
        "다양한 경험이 말해주듯이 <가보지 않은 길>로 가는것을 겁내지 않고 <도전>하며 걸어왔습니다.",
        "현재는 '<Write once, run anywhere>' 라는 표어를 갖는 <Flutter>에 관심이 많으며 보고 있는 웹사이트 또한 Flutter를 이용하여 만들었습니다.",
        "컴퓨터 앞에 앉아 있지 않을 때는 아내가 운영하는 <젤라뚱>으로가서 매장일을 도우며 <젤라또 아이스크림>을 먹거나, <도서관>에가서 무엇인가에 열중하는 사람들을 바라보는 것을 좋아합니다.",
        "언제나 좋은 개발자가 되기 위해 최선을 다합니다."
      ];

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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopHeaderWidget(
            textColor: Colors.white,
            currentRoutePageName: rn.aboutPage,
          ),

          const SizedBox(
            height: 120,
          ),
          _getProfileAndAboutMeDetailWidget(),
          const SizedBox(
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

          const SizedBox(
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
    const double widgetSize = 240;
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
                        offset: const Offset(0, 0),
                        blurRadius: widgetSize,
                        spreadRadius: widgetSize / 2),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
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
                color: const Color.fromARGB(15, 255, 255, 255),
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
                color: const Color.fromARGB(15, 255, 255, 255),
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

  List<Widget> _getAboutMeTextWidgetList() {
    const defaultTextStyle =
        TextStyle(color: Colors.grey, fontSize: 20, height: 1.4);
    const highlightTextStyle =
        TextStyle(color: Colors.white, fontSize: 20, height: 1.4);

    final retVal = <Widget>[];
    for (final aboutMeText in _aboutMe) {
      final textHighlighter = TextHighlighter(aboutMeText);
      final highlightTextModels = textHighlighter.getTexthighlightModel();

      if (aboutMeText.contains('좋은 개발자')) {
        continue;
      }

      final textSpans = <TextSpan>[];
      for (final highlightTextModel in highlightTextModels) {
        var finalHighlightTextStyle = highlightTextStyle;

        final text = highlightTextModel.text;
        final highlight = highlightTextModel.highlight;

        TapGestureRecognizer? gestureRecognizer;
        if (text == 'Flutter') {
          finalHighlightTextStyle =
              highlightTextStyle.copyWith(color: const Color(0xff027DFD));
        } else if (text == '젤라뚱') {
          // finalHighlightTextStyle =
          //     highlightTextStyle.copyWith(color: Color(0xffE94190));
          gestureRecognizer = TapGestureRecognizer()
            ..onTap =
                () => launchUrlString('https://www.instagram.com/gelato_dd/');
        }

        final currentTextSpan = TextSpan(
          text: text,
          style: (highlight) ? finalHighlightTextStyle : defaultTextStyle,
          recognizer: gestureRecognizer,
        );

        textSpans.add(currentTextSpan);
      }

      final columnWidget = Column(
        children: [
          Text.rich(
            TextSpan(
              children: textSpans,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
      retVal.add(columnWidget);
    }

    return retVal;
  }

  Widget _getAboutMeDetailWidget() {
    const defaultTextStyle =
        TextStyle(color: Colors.grey, fontSize: 20, height: 1.4);
    const highlightTextStyle =
        TextStyle(color: Colors.white, fontSize: 20, height: 1.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._getAboutMeTextWidgetList(),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              "언제나 ",
              style: defaultTextStyle,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, rn.goodDeveloper);
              },
              label: const Text(
                '좋은 개발자',
                style: highlightTextStyle,
              ),
              icon: const Icon(
                Icons.thumb_up,
                color: Colors.white,
              ),
              //foregroundColor: Color(0xff4A5BE1),
              backgroundColor: const Color(0xff4A5BE1),
            ),
            const Text(
              " 가 되기위해 최선을 다합니다.",
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
          style: const TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.0),
        ),
        Text(
          _fullNameHangeul,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.0),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          _developerTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          _developerCategory,
          style: const TextStyle(
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
            const SizedBox(
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
            const SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_eamilAddress.isNotEmpty) {
                  launchUrlString('mailto:$_eamilAddress');
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Icon(
                Icons.email,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {
                if (_phoneNumber.isNotEmpty) {
                  launchUrlString('tel:$_phoneNumber');
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: const Icon(
                Icons.phone,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(
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
      return const SizedBox.shrink();
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
                padding: const EdgeInsets.all(8.0),
                child: const Text(
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
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        _whatIsGoodDeveloper[i],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
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
