import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _aniContrl;
  late Animation<double> textSizeGrowingAnimation;

  @override
  void initState() {
    super.initState();

    _aniContrl =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    textSizeGrowingAnimation = Tween(begin: 14.0, end: 144.0).animate(
        CurvedAnimation(parent: _aniContrl, curve: Curves.bounceInOut));
  }

  bool forwardCompleted = false;
  bool backwardCompleted = false;
  @override
  Widget build(BuildContext context) {
    _aniContrl.repeat(reverse: true);
    return Center(
      child: AnimatedBuilder(
        animation: textSizeGrowingAnimation,
        builder: (context, child) {
          final textSize = textSizeGrowingAnimation.value;
          return Text(
            'a',
            style: TextStyle(fontSize: textSize.toDouble()),
          );
        },
      ),
    );
  }
}
