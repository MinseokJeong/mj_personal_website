import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/slide_up_page_transition_widget.dart';

class TestPage extends StatelessWidget {
  TestPage({required this.number, Key? key}) : super(key: key);

  final int number;

  final _texts = <String>['FIRST', 'SECOND'];
  final _colors = <Color>[Colors.red, Colors.blue];

  @override
  Widget build(BuildContext context) {
    int idx = number % 2;
    return Container(
      color: _colors[idx],
      child: Center(
        child: TextButton(
          child: Text(
            _texts[idx],
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            final prb = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return TestPage(number: number + 1);
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
                  const SlideUpPageTransitionWidget(title: 'haha'),
                ]);
              },
            );
            Navigator.push(context, prb);
          },
        ),
      ),
    );
  }
}
