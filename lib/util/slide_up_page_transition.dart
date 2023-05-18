import 'package:flutter/material.dart';
import '../widget/slide_up_page_transition_widget.dart';

Future<void> slideUpPageTransition(
    BuildContext bc, Widget newPage, String pageTransitionTitle) async {
  final prb = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return newPage;
    },
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
        SlideUpPageTransitionWidget(title: pageTransitionTitle),
      ]);
    },
  );
  await Navigator.push(bc, prb);
  return;
}
