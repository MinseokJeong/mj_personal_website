import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/page/menu_page.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'package:mj_portfolio_web/widget/code_by_minseok_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'interaction_menu_button_widget.dart';
import '../model/route_name.dart' as rn;

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget(
      {Key? key, required this.textColor, this.currentRoutePageName = ''})
      : super(key: key);

  final Color textColor;
  final String currentRoutePageName;

  @override
  Widget build(BuildContext context) {
    final screenSizeWidth = ScreenSize.getScreenWidth(context);
    bool isScreenSizeSmallerThanTablet =
        (screenSizeWidth >= ScreenType.tablet.width);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CodeByMinseokWidget(
            color: textColor,
            onPressed: () {
              Navigator.pushNamed(context, rn.rootPage);
            },
          ),
          const Spacer(),
          if (isScreenSizeSmallerThanTablet) ...[
            InteractionMenuButtonWidget(
              text: 'About',
              onPressed: () {
                Navigator.pushNamed(context, rn.aboutPage);
              },
              textColor: textColor,
              selected: (currentRoutePageName == rn.aboutPage) ? true : false,
            ),
            InteractionMenuButtonWidget(
              text: 'Work',
              onPressed: () {
                Navigator.pushNamed(context, rn.workPage);
                //pt.slideUpPageTransition(context, WorkPage(), 'Work');
              },
              textColor: textColor,
              selected: (currentRoutePageName == rn.workPage) ? true : false,
            ),
            InteractionMenuButtonWidget(
              text: 'Blog',
              onPressed: () {
                launchUrlString('https://minseokjeong.github.io');
              },
              textColor: textColor,
              selected: false,
            ),
          ],
          if (!isScreenSizeSmallerThanTablet)
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
                color: textColor,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
