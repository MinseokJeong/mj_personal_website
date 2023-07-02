import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';

class GoodDeveloperWidget extends StatelessWidget {
  const GoodDeveloperWidget({super.key, required this.whatIsGoodDeveloper});

  final List<String> whatIsGoodDeveloper;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.transparent;
    const largeTextColor = Colors.white;
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: Text(
                "'좋은 개발자'",
                style: TextStyle(color: largeTextColor, fontSize: 40),
              ),
            ),
          ),
          _goodDeveloperDescribeWidget(context),
        ],
      ),
    );
  }

  Widget _goodDeveloperDescribeWidget(BuildContext context) {
    final lapTopLargeWidth = ScreenType.laptopLarge.width;
    final screenWidth = ScreenSize.getScreenWidth(context);
    if (screenWidth >= lapTopLargeWidth) {
      return Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox.shrink(),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Column(
              children: [
                for (int i = 0; i < whatIsGoodDeveloper.length / 2; ++i)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child:
                        _goodDeveloperTextWidget(i + 1, whatIsGoodDeveloper[i]),
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: Column(
              children: [
                for (int i = (whatIsGoodDeveloper.length / 2).toInt();
                    i < whatIsGoodDeveloper.length;
                    ++i)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child:
                        _goodDeveloperTextWidget(i + 1, whatIsGoodDeveloper[i]),
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox.shrink(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          for (int i = 0; i < whatIsGoodDeveloper.length; ++i)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: _goodDeveloperTextWidget(i + 1, whatIsGoodDeveloper[i]),
            ),
        ],
      );
    }
  }

  Widget _goodDeveloperTextWidget(int number, String text) {
    final smallTextColor = Colors.grey;
    final normalTextColor = Colors.white;

    return Wrap(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${number}. ',
                style: TextStyle(
                  color: smallTextColor,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(color: normalTextColor, fontSize: 18),
              )
            ],
          ),
          softWrap: true,
        ),
      ],
    );
  }
}
