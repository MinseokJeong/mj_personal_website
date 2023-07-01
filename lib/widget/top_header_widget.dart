import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'interaction_menu_button_widget.dart';
import '../model/route_name.dart' as rn;

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({Key? key, required this.textColor}) : super(key: key);

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    double leftPadding = 40.0;
    TextAlign textAlign = TextAlign.center;

    var text = '@ Code by MinseokJeong';

    if (ScreenSize.isNotLargeScreenSize(context)) {
      leftPadding = 8.0;
      textAlign = TextAlign.left;
      text = "@ Code by Minseok";
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: leftPadding),
            child: Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                  fontSize: 16.0,
                  color: textColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const Spacer(),
          InteractionMenuButtonWidget(
            text: 'Home',
            onPressed: () {
              Navigator.pushNamed(context, rn.homePage);
            },
            textColor: textColor,
          ),
          InteractionMenuButtonWidget(
            text: 'Work',
            onPressed: () {
              Navigator.pushNamed(context, rn.workPage);
              //pt.slideUpPageTransition(context, WorkPage(), 'Work');
            },
            textColor: textColor,
          ),
          InteractionMenuButtonWidget(
            text: 'About',
            onPressed: () {
              Navigator.pushNamed(context, rn.aboutPage);
            },
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}
