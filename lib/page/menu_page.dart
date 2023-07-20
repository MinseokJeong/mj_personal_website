import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../model/route_name.dart' as rn;

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff1C1D20);
    const dividerColor = Color(0xff4E4F51);
    const smallTextColor = Color(0xff8C8C8E);
    const largeTextColor = Color(0xffffffff);
    const closeButtonBackgroundColor = Color(0xff4A5BE1);
    const closeButtonIconColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: closeButtonBackgroundColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.close_sharp,
                      color: closeButtonIconColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text(
                'Navigation',
                style: TextStyle(color: smallTextColor, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: dividerColor,
              ),
            ),
            _CustomRowTextButton(
              text: 'About',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, rn.aboutPage, (_) => false);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'Work',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, rn.workPage, (_) => false);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'Blog',
              onPressed: () {
                launchUrlString('https://minseokjeong.github.io');
              },
            ),
            const Expanded(child: SizedBox.shrink()),
            FooterWidget(
              defaultColor: Colors.grey,
              highlightColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomRowTextButton extends StatefulWidget {
  _CustomRowTextButton({required this.text, required this.onPressed});

  void Function() onPressed;
  String text;

  @override
  State<_CustomRowTextButton> createState() => __CustomRowTextButtonState();
}

class __CustomRowTextButtonState extends State<_CustomRowTextButton>
    with SingleTickerProviderStateMixin {
  bool hoveredState = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: (hoveredState)
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (event) {
          setState(() {
            _animationController.reset();
            _animationController.forward();
            hoveredState = true;
          });
        },
        onExit: (event) {
          setState(() {
            _animationController.reverse();
            hoveredState = false;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
