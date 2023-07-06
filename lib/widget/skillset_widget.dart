import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';
import 'package:mj_portfolio_web/widget/tag_widget.dart';

import '../model/size_variation.dart';

class SkillSetWidget extends StatelessWidget {
  SkillSetWidget({super.key, required this.skills});
  final _backgroundColor = const Color(0xffE9EAEB);
  List<(String category, List<String> list)> skills;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //color: tra,
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Skills",
            style: TextStyle(color: Colors.white, fontSize: 48),
          ),
          const SizedBox(
            height: 80,
          ),
          ..._getSkillSetSubSectionWidgets(context),
          const SizedBox(
            height: 160,
          ),
        ],
      ),
    );
  }

  List<Widget> _getSkillSetSubSectionWidgets(BuildContext context) {
    if (skills.isEmpty) {
      return [];
    }
    final widgets = <Widget>[];
    final lengthOfSkills = skills.length;
    const emptySpaceWidget =
        Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox.shrink());
    int rowPerItemCount = 3;

    if (ScreenSize.getScreenWidth(context) < ScreenType.laptop.width) {
      rowPerItemCount = 2;
      for (int i = 0; i <= lengthOfSkills ~/ rowPerItemCount; i += 1) {
        widgets.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (rowPerItemCount * i < lengthOfSkills)
                ? _SkillSetSubSectionWidget(
                    number: rowPerItemCount * i + 1,
                    header: skills[rowPerItemCount * i].$1,
                    tags: skills[rowPerItemCount * i].$2,
                  )
                : emptySpaceWidget,
            (rowPerItemCount * i + 1 < lengthOfSkills)
                ? _SkillSetSubSectionWidget(
                    number: rowPerItemCount * i + 2,
                    header: skills[rowPerItemCount * i + 1].$1,
                    tags: skills[rowPerItemCount * i + 1].$2,
                  )
                : emptySpaceWidget,
          ],
        ));
        widgets.add(const SizedBox(
          height: 60,
        ));
      }
    } else {
      for (int i = 0; i <= lengthOfSkills ~/ rowPerItemCount; i += 1) {
        widgets.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (rowPerItemCount * i < lengthOfSkills)
                ? _SkillSetSubSectionWidget(
                    number: rowPerItemCount * i + 1,
                    header: skills[rowPerItemCount * i].$1,
                    tags: skills[rowPerItemCount * i].$2,
                  )
                : emptySpaceWidget,
            (rowPerItemCount * i + 1 < lengthOfSkills)
                ? _SkillSetSubSectionWidget(
                    number: rowPerItemCount * i + 2,
                    header: skills[rowPerItemCount * i + 1].$1,
                    tags: skills[rowPerItemCount * i + 1].$2,
                  )
                : emptySpaceWidget,
            (rowPerItemCount * i + 2 < lengthOfSkills)
                ? _SkillSetSubSectionWidget(
                    number: rowPerItemCount * i + 3,
                    header: skills[rowPerItemCount * i + 2].$1,
                    tags: skills[rowPerItemCount * i + 2].$2,
                  )
                : emptySpaceWidget,
          ],
        ));
        widgets.add(const SizedBox(
          height: 60,
        ));
      }
    }

    return widgets;
  }
}

class _SkillSetSubSectionWidget extends StatelessWidget {
  _SkillSetSubSectionWidget(
      {required this.number,
      required this.header,
      required this.tags});
  int number;
  String header;
  List<String> tags;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    const textStyle2 = TextStyle(color: Colors.grey);

    final fontSizeVariation = SizeVariation(
      whenType4K: 32,
      whenTypeLaptopLarge: 32,
      whenTypeLaptop: 24,
      whenTypeTablet: 24,
      whenTypeMobileLarge: 24.0,
      whenTypeMobileMedium: 18.0,
      whenTypeMobileSmall: 18.0,
    );

    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                AutoSizeText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$number'.padLeft(2, '0'),
                        style: textStyle2.copyWith(fontSize: 14),
                      ),
                      TextSpan(
                        text: ' $header',
                        style: textStyle.copyWith(
                          fontSize:
                              fontSizeVariation.getSizeWithContext(context),
                        ),
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              color: const Color(0xffCDCED0),
              height: 1,
              width: double.infinity,
            ),
            const SizedBox(
              height: 32,
            ),
            const SizedBox(
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
                        padding: const EdgeInsets.symmetric(
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
