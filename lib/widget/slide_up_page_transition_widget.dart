import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';

class SlideUpPageTransitionWidget extends StatefulWidget {
  const SlideUpPageTransitionWidget({required this.title, Key? key})
      : super(key: key);

  final String title;

  @override
  State<SlideUpPageTransitionWidget> createState() =>
      _SlideUpPageTransitionWidgetState();
}

class _SlideUpPageTransitionWidgetState
    extends State<SlideUpPageTransitionWidget> with TickerProviderStateMixin {
  late AnimationController _screenSlideUpAnimationController;
  late Animation<Offset> _screenSlideUpAnimation;

  bool _visibility = true;

  @override
  void initState() {
    super.initState();

    _screenSlideUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2800));

    _screenSlideUpAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _visibility = false;
        setState(() {});
      }
    });
    _screenSlideUpAnimationController.reset();
    // _screenSlideUpAnimation2 = Tween(begin: 0.0, end: 1.0).animate(
    //     CurvedAnimation(
    //         curve: Curves.easeInOutQuart,
    //         parent: _screenSlideUpAnimationController2));
  }

  @override
  void dispose() {
    _screenSlideUpAnimationController.dispose();

    super.dispose();
  }

  Widget _getTextWidget(BuildContext context) {
    double fontSizeLarge = 96.0;
    double fontSizeSmall = 32.0;

    if (ScreenSize.isTabletScreenSize(context) ||
        ScreenSize.isMobileScreenSize(context)) {
      fontSizeLarge /= 3.0;
      fontSizeSmall /= 3.0;
    }

    final baseTextStyle = TextStyle(
      fontSize: fontSizeLarge,
      color: Colors.white,
    );
    final color1 = HexColor('#DADAAA');
    final color2 = HexColor('#5C9EFC');
    final color3 = HexColor('#B98C76');
    final color4 = HexColor('#D3D3D3');

    return Text.rich(
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
            text: widget.title,
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
  }

  @override
  Widget build(BuildContext context) {
    _screenSlideUpAnimationController.forward();

    final windowSize = ScreenSize.getScreenSize(context);
    const circularBoxHeight = 300.0;

    _screenSlideUpAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0.0, windowSize.height),
          end: const Offset(0.0, -circularBoxHeight),
        ).chain(
          CurveTween(curve: Curves.easeInOutQuart),
        ),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: ConstantTween(
          const Offset(0.0, -circularBoxHeight),
        ),
        weight: 0.6,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0.0, -circularBoxHeight),
          end: Offset(
            0.0,
            -(circularBoxHeight * 2.0 + windowSize.height),
          ),
        ).chain(
          CurveTween(curve: Curves.easeInOutQuart),
        ),
        weight: 0.4,
      ),
    ]).animate(_screenSlideUpAnimationController);

    return Visibility(
      visible: _visibility,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _screenSlideUpAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _screenSlideUpAnimation.value,
                  child: UnconstrainedBox(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: windowSize.width,
                        height: circularBoxHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(
                                windowSize.width / 2.0, circularBoxHeight),
                            topRight: Radius.elliptical(
                                windowSize.width / 2.0, circularBoxHeight),
                          ),
                        ),
                      ),
                      child!,
                      Container(
                        width: windowSize.width,
                        height: circularBoxHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(
                                windowSize.width / 2.0, circularBoxHeight),
                            bottomRight: Radius.elliptical(
                                windowSize.width / 2.0, circularBoxHeight),
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
                  child: _getTextWidget(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
