import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';

class WhoAmIText {
  final int number;
  final String header;
  final String text;

  WhoAmIText(this.number, this.header, this.text);
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pictureRotateAnimationController;
  late Animation<double> _pictureRotateAniamtion;

  final _whoAmITexts = <WhoAmIText>[
    WhoAmIText(1, "리더, 동료들과 의견을 맞추고 개인의 목표를 조직 목표와 정렬시킵니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(2, "업무 목표와 과제에 몰입하고, 목표 달성을 위해 최선을 다합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(3, "우리 개발 조직의 상황과 맥락을 이해하고 조직의 약속을 잘 따릅니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(4, "업무의 중요도에 따라 우선순위를 선정하고 순서에 맞게 처리합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(5, "결과물이 목표와 구현 의도에 부합하는지 항상 점검하고, 다양한 대안을 고민합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(6, "주어진 업무에 안주하지 않고 자신의 역할과 책임 범위를 확장합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(7, "동료와 선배 개발자의 피드백을 긍정적으로 수용하여 더 좋은 결과를 만듭니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(8, "함께 일하는 동료들과의 분위기를 긍정적으로 만들고 사기를 높입니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(9, "동료들과 어려움을 함께 고민하고, 조언과 도움을 주고 받습니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(10, "동료들과 노하우를 공유하고 동료의 성장을 돕습니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(11, "문제의 원인을 파악하고 해결방안을 도출하는 능력이 매우 뛰어납니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(12, "자신의 성과와 행동을 객관적으로 회고하고, 나아지기 위해 노력합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(13, "결과물의 품질을 높이기 위해 다양한 기술에 관심을 가지고 연구합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(14, "새로운 기술을 습득하는 능력이 뛰어납니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(15, "다양한 기술을 목적에 맞게 사용하여 업무의 효율성을 높입니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(16, "동료들에게 기술적인 도움을 제공하여 팀 전체의 효율성을 높입니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(17, "비슷한 경력의 개발자들 중에서도 효율적으로 많은 양의 업무를 처리합니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(18, "업무 난이도와 상관없이 기대 이상의 결과물을 만들어 냅니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(19, "개발 결과물로 다양한 동료(개발/기획/디자인/QA)에게 인정 받습니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
    WhoAmIText(20, "개발자로서 닮고 싶고, 배우고 싶은 마음이 드는 동료입니다.",
        "위 헤더에 관해서 이러이러한 일을 겪은 실제 에피소드는 이러이러 합니다."),
  ];

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#1C1D20"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopHeaderWidget(
                textColor: Colors.white,
              ),
              SizedBox(
                height: 120,
              ),
              _getProfileAndAboutMeDetailWidget(),
              SizedBox(
                height: 32.0,
              ),
              _getAnimatedGooDeveloperWidget(),
              SizedBox(
                height: 30,
              ),
              FooterWidget(
                highlightColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
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
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ..._whoAmITexts.map(
                    (e) => RotateAnimatedText(e.header,
                        rotateOut: true,
                        duration: Duration(milliseconds: 2000),
                        transitionHeight: 20.0 * 10.0 / 3.0 * 2,
                        textStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white)),
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
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ..._whoAmITexts.map(
                      (e) => RotateAnimatedText(e.header,
                          rotateOut: true,
                          duration: Duration(milliseconds: 2000),
                          transitionHeight: 20.0 * 10.0 / 3.0 * 2,
                          textStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
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
              width: 1024,
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
    final texts = [
      //" 대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에있는 회사에서 Android 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 Windows 개발자로 일을 하였고, 스타트업회사를 공동창업하며 Andoid/iOS 개발자로 일을 하였고, 방위산업체에서 근무하며 Embedded System/Firmware/Windows 개발자로 일을 한 경험이 있습니다.",
      //" 다양한 플랫폼을 경험하면서 컴퓨터 및 프로그래밍에 대한 이해가 넓고 깊으며 새로운 기술을 습득하는 능력이 뛰어납니다.",
      //" 위의 다양한 개발경험과 같이 가보지 않은 길로 도전하는것을 즐기며 실패를 겁내지 않습니다.",
      //" 기업가정신을 추구하며 많은사람에게 가치가 있고 도움이되는 상품/서비스를 만드는것을 목표로 합니다.",
      //" 언제나 '좋은 개발자'가 되기위해 최선을 다합니다.",
      //" 국가/인종/나이와 상관없이 두루두루 원만한 인간관계를 가지고 있습니다.",
    ];

    final greyTextStyle =
        TextStyle(color: Colors.grey, fontSize: 20, height: 1.4);
    final whiteTextStyle =
        TextStyle(color: Colors.white, fontSize: 20, height: 1.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에있는 회사에서 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Android',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: ' 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Windows',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: ' 개발자로 일을 하였고, 스타트업회사를 공동창업하며 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Andoid',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '/',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'iOS',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: ' 개발자로 일을 하였고, 방위산업체에서 근무하며 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Embedded System',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '/',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Firmware',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '/',
                style: greyTextStyle,
              ),
              TextSpan(
                text: 'Windows',
                style: greyTextStyle,
              ),
              TextSpan(
                text: ' 개발자로 일을 한 경험이 있습니다.',
                style: greyTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '다양한 플랫폼을 경험하면서 컴퓨터 및 프로그래밍에 대한 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '이해',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '가 넓고 깊으며 새로운',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '기술',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '을 습득하는 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '능력',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '이 뛰어납니다.',
                style: greyTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '위의 다양한 개발경험과 같이 가보지 않은 길로 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '도전',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '하는것을 즐기며 실패를 겁내지 않습니다.',
                style: greyTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '기업가정신',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: ' 을 추구하며 많은사람에게 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '가치',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '가 있고 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '도움',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '이되는 상품/서비스를 만드는것을 ',
                style: greyTextStyle,
              ),
              TextSpan(
                text: '목표',
                style: whiteTextStyle,
              ),
              TextSpan(
                text: '로 합니다.',
                style: greyTextStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "언제나 '",
                style: greyTextStyle,
              ),
              TextSpan(
                text: "좋은 개발자",
                style: whiteTextStyle,
              ),
              TextSpan(
                text: "'가 되기위해 최선을 다합니다.",
                style: greyTextStyle,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 30.0,
        // ),
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: "국가/인종/나이와 상관없이 두루두루  ",
        //         style: greyTextStyle,
        //       ),
        //       TextSpan(
        //         text: "원만한 인간관계",
        //         style: whiteTextStyle,
        //       ),
        //       TextSpan(
        //         text: "를 가지고 있습니다.",
        //         style: greyTextStyle,
        //       ),
        //     ],
        //   ),
        // ),
        // ...texts.map(
        //   (e) => Padding(
        //     padding: const EdgeInsets.only(top: 30.0),
        //     child: Text(
        //       e,
        //       style: TextStyle(color: Colors.grey, fontSize: 20, height: 1.4),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _getProfileWidget() {
    var fullNameInEnglish = 'Minseok Jeong';
    var fullNameInHangeul = '정민석';
    var developerTitle = 'Software Engineer & Developer';
    var identity = "모바일 / 웹 / 데스크탑 / 임베디드 / 펌웨어 개발자";
    const iconColor = Colors.grey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullNameInEnglish,
          style: TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w700,
              height: 1.0),
        ),
        Text(
          fullNameInHangeul,
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
          developerTitle,
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
          identity,
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
              onPressed: () {},
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
              onPressed: () {},
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
              onPressed: () {},
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
              onPressed: () {},
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
              onPressed: () {},
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
}
