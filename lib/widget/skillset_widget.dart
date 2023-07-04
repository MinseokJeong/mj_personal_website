import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/tag_widget.dart';

class SkillSetWidget extends StatelessWidget {
  SkillSetWidget({super.key, required this.skills});
  final _backgroundColor = Color(0xffE9EAEB);
  List<(String category, List<String> list)> skills;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //color: tra,
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "Skills",
            style: TextStyle(color: Colors.white, fontSize: 48),
          ),
          SizedBox(
            height: 80,
          ),
          ..._getSkillSetSubSectionWidgets(),
          SizedBox(
            height: 160,
          ),
        ],
      ),
    );
  }

  List<Widget> _getSkillSetSubSectionWidgets() {
    final widgets = <Widget>[];

    for (int i = 0; i < skills.length ~/ 3; i += 1) {
      widgets.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkillSetSubSectionWidget(
            number: 3 * i + 1,
            header: skills[3 * i].$1,
            tags: skills[3 * i].$2,
          ),
          _SkillSetSubSectionWidget(
            number: 3 * i + 2,
            header: skills[3 * i + 1].$1,
            tags: skills[3 * i + 1].$2,
          ),
          _SkillSetSubSectionWidget(
            number: 3 * i + 3,
            header: skills[3 * i + 2].$1,
            tags: skills[3 * i + 2].$2,
          ),
        ],
      ));
      widgets.add(SizedBox(
        height: 60,
      ));
    }

    //Code can be reduce by merge below code to above loop.
    if (skills.length % 3 != 0) {
      int i = (skills.length / 3).toInt();
      final firstWidget = (skills.elementAtOrNull(i * 3) != null)
          ? _SkillSetSubSectionWidget(
              number: 3 * i + 1,
              header: skills[3 * i].$1,
              tags: skills[3 * i].$2,
            )
          : Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink());

      final secondWidget = (skills.elementAtOrNull(i * 3 + 1) != null)
          ? _SkillSetSubSectionWidget(
              number: 3 * i + 2,
              header: skills[3 * i + 1].$1,
              tags: skills[3 * i + 1].$2,
            )
          : Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink());

      final thirdWidget = (skills.elementAtOrNull(i * 3 + 2) != null)
          ? _SkillSetSubSectionWidget(
              number: 3 * i + 3,
              header: skills[3 * i + 2].$1,
              tags: skills[3 * i + 2].$2,
            )
          : Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink());
      widgets.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [firstWidget, secondWidget, thirdWidget],
      ));
      widgets.add(SizedBox(
        height: 60,
      ));
    }

    return widgets;
  }
}

class _SkillSetSubSectionWidget extends StatelessWidget {
  _SkillSetSubSectionWidget(
      {super.key,
      required this.number,
      required this.header,
      required this.tags});
  int number;
  String header;
  List<String> tags;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white);
    final textStyle2 = TextStyle(color: Colors.grey);

    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${number}'.padLeft(2, '0'),
              style: textStyle2.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              color: Color(0xffCDCED0),
              height: 1,
              width: double.infinity,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              header,
              style: textStyle.copyWith(fontSize: 32),
            ),
            SizedBox(
              height: 32,
            ),
            if (tags.isNotEmpty)
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  ...tags.map((e) => TagWidget(
                        tag: e,
                        fontSize: 14,
                        textColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        borderRadius: 6,
                        borderColor: Colors.grey,
                        borderWidth: 2.0,
                      ))
                ],
              ),
          ],
        ),
      ),
    );
  }
}
