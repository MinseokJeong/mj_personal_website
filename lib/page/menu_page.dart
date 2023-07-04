import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/route_name.dart' as rn;

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 48,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_sharp,
                    color: Colors.white,
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
                style: TextStyle(color: Colors.grey, fontSize: 14),
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
                color: Colors.grey,
              ),
            ),
            _CustomRowTextButton(
              text: 'Home',
              onPressed: () {
                Navigator.pushNamed(context, rn.homePage);
              },
            ),
            SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'Work',
              onPressed: () {
                Navigator.pushNamed(context, rn.workPage);
              },
            ),
            SizedBox(
              height: 32,
            ),
            _CustomRowTextButton(
              text: 'About',
              onPressed: () {
                Navigator.pushNamed(context, rn.aboutPage);
              },
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
    return MouseRegion(
      cursor:
          (hoveredState) ? SystemMouseCursors.click : SystemMouseCursors.basic,
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
