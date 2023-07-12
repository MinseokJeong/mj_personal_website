import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
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

  final _helloSvgFilePaths = <String>[
    "assets/hello/hello_english.svg",
    "assets/hello/hello_china.svg",
    "assets/hello/hello_rusia.svg",
    "assets/hello/hello_france.svg",
    "assets/hello/hello_japan.svg",
    "assets/hello/hello_germany.svg",
    "assets/hello/hello_italy.svg",
    "assets/hello/hello_arab.svg",
    "assets/hello/hello_korea.svg",
  ];

  @override
  void initState() {
    super.initState();
    _aniContrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600));

    final endComputed = (_helloSvgFilePaths.length - 1).toDouble();
    _textIndexAnimation =
        Tween(begin: 0.0, end: endComputed).animate(_aniContrl);

    _textIndexAnimation = TweenSequence([
      for (int i = 0; i < _helloSvgFilePaths.length; ++i)
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
                padding: EdgeInsets.all(32.0),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _textIndexAnimation,
                    builder: (context, child) {
                      final index = _textIndexAnimation.value.toInt();
                      final currentHelloTextSvgFilePath =
                          _helloSvgFilePaths.elementAt(index);

                      return SvgPicture.asset(
                        currentHelloTextSvgFilePath,
                        height: windowSize.width * 0.1,
                        fit: BoxFit.fitHeight,
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
