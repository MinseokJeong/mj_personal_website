import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_portfolio_web/rotate_sphere.dart';
import 'package:mj_portfolio_web/top_section.dart';

enum _FontName {
  NotoSans,
  NotoSansJapanese,
  NotoSansKorean,
}

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

  bool _visibility = true;

  /*
  10대강국
  미국,영국 Hello(헬로)
  중국 你好(니하오)
  러시아 Здравствуйте(즈드랏스부이쩨)
  프랑스 Bonjuor(봉쥬흐)
  일본 こんにちは(곤니찌와)
  독일 Guten Tag(구텐탁)
  이탈리아 Buongiorno(본조르노)
  인도 नमस्ते(나마스떼)
  한국 안녕하세요
  */

  final _helloTextsInDifferentLanguageTextAndFontMap = <String, String>{
    'Hello': _FontName.NotoSans.name,
    '你好': _FontName.NotoSansJapanese.name,
    'Здравствуйте': _FontName.NotoSans.name,
    'Bonjuor': _FontName.NotoSans.name,
    'こんにちは': _FontName.NotoSansJapanese.name,
    'Guten Tag': _FontName.NotoSans.name,
    'Buongiorno': _FontName.NotoSans.name,
    'नमस्ते': _FontName.NotoSans.name,
    '안녕하세요': _FontName.NotoSansKorean.name,
  };

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
          _screenSlideUpAnimationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _visibility = false;
              });
            }
          });
        }
      });
      _aniContrl.forward();
    });

    final windowSize = MediaQuery.of(context).size;

    return Visibility(
      visible: _visibility,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      final text = _helloTextsInDifferentLanguageTextAndFontMap
                          .keys
                          .elementAt(index);
                      final font =
                          _helloTextsInDifferentLanguageTextAndFontMap[text];
                      return Text(
                        '# ${text}',
                        style: TextStyle(
                            fontSize: 96.0,
                            color: Colors.white,
                            fontFamily: font),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
