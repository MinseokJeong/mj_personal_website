import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
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
        padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: closeButtonBackgroundColor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.close_sharp,
                      color: closeButtonIconColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Navigation',
                style: TextStyle(color: smallTextColor, fontSize: 14),
              ),
            ),
            SizedBox(
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
              text: 'Home',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, rn.homePage, (_) => false);
              },
            ),
            SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'Work',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, rn.workPage, (_) => false);
              },
            ),
            SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'About',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, rn.aboutPage, (_) => false);
              },
            ),
            Expanded(child: SizedBox.shrink()),
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
  _CustomRowTextButton(
      {super.key, required this.text, required this.onPressed});

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
      duration: Duration(milliseconds: 200),
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              widget.text,
              style: TextStyle(
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
