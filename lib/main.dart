import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_portfolio_web/page/menu_page.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import 'model/enum_screen_type.dart';
import 'page/unknown_page.dart';
import 'widget/slide_up_page_transition_widget.dart';
import 'my_web_app.dart';
import 'page/about_page.dart';
import 'page/work_page.dart';
import 'page/home_page.dart';
import 'app_design_resources.dart' show FontName;
import 'model/route_name.dart' as rn;
import 'package:flutter_web_plugins/url_strategy.dart';

final _routes = <String, Widget Function(BuildContext)>{
  rn.rootPage: (bc) => MyWebApp(),
  rn.homePage: (bc) => const HomePage(),
  rn.aboutPage: (bc) => const AboutPage(),
  rn.workPage: (bc) => const WorkPage(),
};

void main() {
  usePathUrlStrategy();

  ScreenTypeExtension.baseScreenType = ScreenType.laptopLarge;

  //ForDebug
  return runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
      debugShowCheckedModeBanner: false,
    ),
  );

  return runApp(
    MaterialApp(
      //routes: _routes,
      //onGenerateInitialRoutes: ,
      onGenerateRoute: (settings) {
        if (settings.name == rn.rootPage) {
          return MaterialPageRoute(builder: _routes[rn.rootPage]!);
        } else if (settings.name == rn.aboutPage ||
            settings.name == rn.workPage ||
            settings.name == rn.homePage) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return _routes[settings.name!]!(context);
            },
            transitionDuration: const Duration(seconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return Stack(children: [
                AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      final animationValue = animation.value;
                      double opacity = 0.0;
                      if (animationValue >= 1.0) {
                        opacity = 1.0;
                      }

                      return Opacity(
                        opacity: opacity,
                        child: child,
                      );
                    },
                    child: child),
                SlideUpPageTransitionWidget(title: settings.name!),
              ]);
            },
          );
        }
        // Unknown route
        return MaterialPageRoute(builder: (_) => const UnknownPage());
      },
      initialRoute: rn.rootPage,
      theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
      debugShowCheckedModeBanner: false,
    ),
  );
}
