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
  List<(String, List<String>)> _skillSet = [];

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
    final skillSetList = <(String, List<String>)>[];
    for (final category in skillSets.keys) {
      final skills = List<String>.from(skillSets[category]);
      skillSetList.add((category, skills));
    }
    // final programmingLanguages =
    //     List<String>.from(skillSets['Programming Languages']);

    // final frontEnd = List<String>.from(skillSets['Front-End']);
    // final embedded = List<String>.from(skillSets['Embedded System / Firmware']);
    // final backend = List<String>.from(skillSets['Back-End']);
    // final toolingDevOps = List<String>.from(skillSets['Tooling / DevOps']);
    // final environment = List<String>.from(skillSets['Environment']);
    // final db = List<String>.from(skillSets['DB']);
    // final etc = List<String>.from(skillSets['ETC']);

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

      _skillSet = skillSetList;
      // _skillSetProgrammingLanguage = programmingLanguages;
      // _skillSetFrontend = frontEnd;
      // _skillSetEmbedded = embedded;
      // _skillSetBackend = backend;
      // _skillSetToolingDevops = toolingDevOps;
      // _skillSetEnvironment = environment;
      // _skillSetDB = db;
      // _skillSetEtc = etc;
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
                  skills: _skillSet,
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
    final screenWidth = ScreenSize.getScreenWidth(context);

    if (screenWidth < ScreenType.tablet.width) {
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

      final textSpans = <TextSpan>[];
      for (final highlightTextModel in highlightTextModels) {
        var finalHighlightTextStyle = highlightTextStyle;

        final text = highlightTextModel.text;
        final highlight = highlightTextModel.highlight;

        TapGestureRecognizer? gestureRecognizer;
        if (text == '좋은 개발자') {
          gestureRecognizer = TapGestureRecognizer()
            ..onTap = () => Navigator.pushNamed(context, rn.goodDeveloper);
          final currentTextSpan = TextSpan(
            text: text,
            style: finalHighlightTextStyle.copyWith(
                color: HexColor('#FEA53C'),
                fontWeight: FontWeight.bold,
                fontSize: finalHighlightTextStyle.fontSize! + 2.0),
            recognizer: gestureRecognizer,
          );

          textSpans.add(currentTextSpan);
        } else {
          final currentTextSpan = TextSpan(
            text: text,
            style: (highlight) ? finalHighlightTextStyle : defaultTextStyle,
            recognizer: gestureRecognizer,
          );

          textSpans.add(currentTextSpan);
        }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._getAboutMeTextWidgetList(),
      ],
    );
  }

  Widget _getProfileWidget() {
    const iconColor = Colors.grey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: _fullNameEnglish,
            ),
            TextSpan(
              text: '\n',
            ),
            TextSpan(
              text: _fullNameHangeul,
            ),
          ]),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.3),
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
