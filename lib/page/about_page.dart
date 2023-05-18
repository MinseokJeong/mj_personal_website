import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';

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

class _AboutPageState extends State<AboutPage> {
  double _translateY = 0.0;

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: HexColor("#1C1D20"),
        child: Column(
          children: [
            TopHeaderWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 200.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'About\nMinseok Jeong',
                    style: TextStyle(
                        color: Colors.white, fontSize: 90.0, height: 1.0),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  for (final whoAmITextItem in _whoAmITexts)
                    _describeItemWidget(whoAmITextItem.number,
                        whoAmITextItem.header, whoAmITextItem.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _describeItemWidget(int leftNumber, String header, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: HexColor('#494A4D'), width: 1.0),
        ),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  leftNumber.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: HexColor('#494A4D'), fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                header,
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              Text(
                text,
                style: TextStyle(color: HexColor('#494A4D'), fontSize: 18.0),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
