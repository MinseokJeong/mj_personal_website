import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:mj_portfolio_web/top_section.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _aniContrl;
  late Animation<double> _textIndexAnimation;

  late AnimationController _screenSlideUpAnimationController;
  late Animation<double> _screenSlideUpAnimation;

  final _helloTextsInDifferentLanguage = <String>[
    '안녕하세요',
    'Hello'
        'कुशल',
    'こんにちは',
    '你好',
    'Xin chào',
    'Ciao',
    'Guten Tag ',
    'Hola',
    'Hej',
    'salve',
    'Apa kabar',
    'สวัสดีครับ',
    'merhaba',
    'Сайн байна уу.',
    'Здравствуйте',
  ];

  @override
  void initState() {
    super.initState();
    _aniContrl =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _textIndexAnimation = Tween(begin: 0.0, end: 8.0).animate(_aniContrl);

    _screenSlideUpAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _screenSlideUpAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Curves.easeInOutQuart,
            parent: _screenSlideUpAnimationController));
  }

  bool forwardCompleted = false;
  bool backwardCompleted = false;

  @override
  void dispose() {
    _aniContrl.dispose();
    _screenSlideUpAnimationController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSlideUpAnimationController.reset();
    Future.delayed(Duration.zero, () {
      _aniContrl.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _screenSlideUpAnimationController.forward();
        }
      });
      _aniContrl.forward();
    });

    final windowSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _screenSlideUpAnimation,
            builder: (context, child) {
              final calculatedOffsetY =
                  Tween(begin: 0.0, end: -windowSize.height)
                      .evaluate(_screenSlideUpAnimation);
              return Transform.translate(
                offset: Offset(0.0, calculatedOffsetY),
                child: child,
              );
            },
            child: Container(
              width: windowSize.width,
              height: windowSize.height,
              color: Colors.black,
              child: Center(
                child: AnimatedBuilder(
                  animation: _textIndexAnimation,
                  builder: (context, child) {
                    final index = _textIndexAnimation.value.toInt();
                    print('${index}');
                    return Text(
                      '# ${_helloTextsInDifferentLanguage.elementAt(index)}',
                      style: TextStyle(fontSize: 96.0, color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
          TopSection(),
        ],
      ),
    );
  }
}
