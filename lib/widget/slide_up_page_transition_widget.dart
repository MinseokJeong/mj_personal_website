import 'dart:html';

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
    final windowHeight = windowSize.height;
    final windowWidth = windowSize.width;
    final upperBelowBoxHeight = windowHeight * 0.33;
    final backgroundColor = Colors.black;

    _screenSlideUpAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: Offset(0.0, windowHeight + upperBelowBoxHeight),
          end: const Offset(0.0, 0.0),
        ).chain(
          CurveTween(curve: Curves.easeInOutQuart),
        ),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: ConstantTween(
          const Offset(0.0, 0.0),
        ),
        weight: 0.6,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(0.0, 0.0),
          end: Offset(
            0.0,
            -(upperBelowBoxHeight + windowHeight),
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
                final currentCenterBoxSlideUpAnimationOffset =
                    _screenSlideUpAnimation.value;
                final upperBoxOffset = Offset(
                    0,
                    currentCenterBoxSlideUpAnimationOffset.dy -
                        upperBelowBoxHeight +
                        2.0);
                return Transform.translate(
                  offset: upperBoxOffset,
                  child: child!,
                );
              },
              child: Container(
                width: windowWidth,
                height: upperBelowBoxHeight,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(
                        windowSize.width / 2.0, upperBelowBoxHeight),
                    topRight: Radius.elliptical(
                        windowSize.width / 2.0, upperBelowBoxHeight),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _screenSlideUpAnimation,
              builder: (context, child) {
                final currentCenterBoxSlideUpAnimationOffset =
                    _screenSlideUpAnimation.value;
                final belowBoxOffset = Offset(
                    0,
                    currentCenterBoxSlideUpAnimationOffset.dy +
                        windowHeight -
                        2.0);
                return Transform.translate(
                  offset: belowBoxOffset,
                  child: child!,
                );
              },
              child: Container(
                width: windowWidth,
                height: upperBelowBoxHeight,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                        windowSize.width / 2.0, upperBelowBoxHeight),
                    bottomRight: Radius.elliptical(
                        windowSize.width / 2.0, upperBelowBoxHeight),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _screenSlideUpAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: _screenSlideUpAnimation.value,
                  child: child!,
                );
              },
              child: Container(
                width: windowWidth,
                height: windowHeight,
                color: backgroundColor,
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
