import 'package:flutter/material.dart';
import 'page/unknown_page.dart';
import 'widget/slide_up_page_transition_widget.dart' deferred as suptw;
import 'my_web_app.dart' deferred as mp;
import 'page/about_page.dart' deferred as ap;
import 'page/work_page.dart' deferred as wp;
import 'page/home_page.dart' deferred as hp;
import 'app_design_resources.dart' show FontName;
import 'model/route_name.dart' as rn;

final _routes = <String, Widget Function(BuildContext)>{
  rn.rootPage: (bc) => mp.MyWebApp(),
  rn.homePage: (bc) => hp.HomePage(),
  rn.aboutPage: (bc) => ap.AboutPage(),
  rn.workPage: (bc) => wp.WorkPage(),
};

void main() => runApp(
      MaterialApp(
        routes: _routes,
        onGenerateRoute: (settings) {
          if (settings.name == rn.rootPage) {
            return MaterialPageRoute(builder: _routes[rn.rootPage]!);
          } else if (settings.name == rn.aboutPage ||
              settings.name == rn.workPage) {
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return _routes[settings.name!]!(context);
              },
              transitionDuration: Duration(seconds: 1),
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
                  suptw.SlideUpPageTransitionWidget(title: settings.name!),
                ]);
              },
            );
          }
          // Unknown route
          return MaterialPageRoute(builder: (_) => UnknownPage());
        },
        initialRoute: '/',
        theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
        debugShowCheckedModeBanner: false,
      ),
    );
