import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
import '../app_design_resources.dart' show FontName;
import '../util/screen_size.dart';

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

  final _helloTextsInDifferentLanguageTextAndFontMap = <String, String>{
    'Hello': FontName.NotoSans.name, //미국,영국 Hello(헬로)
    '你好': FontName.NotoSansJapanese.name, //중국 你好(니하오)
    'Здравствуйте': FontName.NotoSans.name, //러시아 Здравствуйте(즈드랏스부이쩨)
    'Bonjuor': FontName.NotoSans.name, //프랑스 Bonjuor(봉쥬흐)
    'こんにちは': FontName.NotoSansJapanese.name, //일본 こんにちは(곤니찌와)
    'Guten Tag': FontName.NotoSans.name, //독일 Guten Tag(구텐탁)
    'Buongiorno': FontName.NotoSans.name, //프랑스 Bonjuor(봉쥬흐)
    'नमस्ते': FontName.NotoSans.name, //인도 नमस्ते(나마스떼)
    '안녕하세요': FontName.NotoSansKorean.name,
  };

  @override
  void initState() {
    super.initState();
    _aniContrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600));

    final endComputed =
        (_helloTextsInDifferentLanguageTextAndFontMap.length - 1).toDouble();
    _textIndexAnimation =
        Tween(begin: 0.0, end: endComputed).animate(_aniContrl);

    _textIndexAnimation = TweenSequence([
      for (int i = 0;
          i < _helloTextsInDifferentLanguageTextAndFontMap.length;
          ++i)
        TweenSequenceItem(
            tween: Tween(begin: i.toDouble(), end: (i + 1).toDouble()),
            weight: 1),
      TweenSequenceItem(tween: ConstantTween(endComputed), weight: 2.0),
    ]).animate(_aniContrl);

    _screenSlideUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _screenSlideUpAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            curve: Curves.easeInOutQuart,
            parent: _screenSlideUpAnimationController));
  }

  @override
  void dispose() {
    _aniContrl.dispose();
    _screenSlideUpAnimationController.dispose();

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

    final windowSize = ScreenSize.getScreenSize(context);

    double fontSizeLarge = 96.0;
    double fontSizeSmall = 32.0;

    if (ScreenSize.isTabletScreenSize(context) ||
        ScreenSize.isMobileScreenSize(context)) {
      fontSizeLarge /= 3.0;
      fontSizeSmall /= 3.0;
    }

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

                const circularBoxHeight = 200.0;
                final bottomCircularBoxHeight = circularBoxHeight -
                    Tween(begin: 0.0, end: circularBoxHeight)
                        .evaluate(_screenSlideUpAnimation);

                return Transform.translate(
                  offset: Offset(0.0, calculatedOffsetY),
                  child: UnconstrainedBox(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    child: Column(children: [
                      child!,
                      Container(
                        width: windowSize.width,
                        height: bottomCircularBoxHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(
                                windowSize.width / 2.0,
                                bottomCircularBoxHeight / 2.0),
                            bottomRight: Radius.elliptical(
                                windowSize.width / 2.0,
                                bottomCircularBoxHeight / 2.0),
                          ),
                        ),
                      ),
                    ]),
                  ),
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
                      final baseTextStyle = TextStyle(
                          fontSize: fontSizeLarge,
                          color: Colors.white,
                          fontFamily: font);
                      final color1 = HexColor('#DADAAA');
                      final color2 = HexColor('#5C9EFC');
                      final color3 = HexColor('#B98C76');
                      final color4 = HexColor('#D3D3D3');

                      final textToDisplay = Text.rich(
                        TextSpan(
                          text: 'print',
                          style: baseTextStyle.copyWith(
                            fontSize: fontSizeSmall,
                            color: color1,
                          ),
                          children: [
                            TextSpan(
                              text: '(',
                              style: baseTextStyle.copyWith(
                                fontSize: fontSizeSmall,
                                color: color2,
                              ),
                            ),
                            TextSpan(
                              text: "'",
                              style: baseTextStyle.copyWith(
                                fontSize: fontSizeSmall,
                                color: color3,
                              ),
                            ),
                            TextSpan(
                              text: text,
                              style: baseTextStyle.copyWith(
                                color: color3,
                              ),
                            ),
                            TextSpan(
                              text: "'",
                              style: baseTextStyle.copyWith(
                                fontSize: fontSizeSmall,
                                color: color3,
                              ),
                            ),
                            TextSpan(
                              text: ')',
                              style: baseTextStyle.copyWith(
                                fontSize: fontSizeSmall,
                                color: color2,
                              ),
                            ),
                            TextSpan(
                              text: ';',
                              style: baseTextStyle.copyWith(
                                fontSize: fontSizeSmall,
                                color: color4,
                              ),
                            ),
                          ],
                        ),
                      );
                      return textToDisplay;
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
