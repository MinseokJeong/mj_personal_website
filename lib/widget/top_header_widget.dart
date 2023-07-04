import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/page/menu_page.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'interaction_menu_button_widget.dart';
import '../model/route_name.dart' as rn;

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({Key? key, required this.textColor}) : super(key: key);

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final screenSizeWidth = ScreenSize.getScreenWidth(context);
    if (screenSizeWidth >= ScreenType.tablet.width) {
      return _forDefaultScreenSizeWidget(context);
    } else {
      return _forSmallScreenSizeWidget(context);
    }
  }

  Widget _forSmallScreenSizeWidget(BuildContext context) {
    double leftPadding = 8.0;
    TextAlign textAlign = TextAlign.left;
    var text = "@ Code by Minseok";

    //final screenSizeWidth = ScreenSize.getScreenHeight(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: leftPadding),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, rn.rootPage);
              },
              child: Text(
                text,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const MenuPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 20,
              )),
        ],
      ),
    );
  }

  Widget _forDefaultScreenSizeWidget(BuildContext context) {
    double leftPadding = 40.0;
    TextAlign textAlign = TextAlign.center;

    var text = '@ Code by MinseokJeong';
    final screenSizeWidth = ScreenSize.getScreenHeight(context);

    if (screenSizeWidth <= ScreenType.tablet.width) {
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
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, rn.rootPage);
              },
              child: Text(
                text,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                    fontWeight: FontWeight.normal),
              ),
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
