import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SecondPart extends StatefulWidget {
  const SecondPart(
      {required this.scrollController, Key? key, this.color = Colors.red})
      : super(key: key);
  final Color color;
  final ScrollController scrollController;

  @override
  State<SecondPart> createState() => _SecondPartState();
}

class _SecondPartState extends State<SecondPart> {
  double _translateY = 0.0;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(this.scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollListener() {
    // final possibleMaxOffset = widget.scrollController.position.maxScrollExtent;
    // final currentOffset = widget.scrollController.offset;
    // final viewPortSize = widget.scrollController.position.viewportDimension;

    // final windowSize = MediaQuery.of(context).size;
    // final currentSectionNumber = 2;
    // final myOffsetLow =
    //     windowSize.height * (currentSectionNumber - 1).toDouble();
    // final myOffsetHigh = windowSize.height * currentSectionNumber.toDouble();
    // final centerOffset = (myOffsetHigh + myOffsetLow) / 2.0;

    // final betweenOffset = centerOffset - (viewPortSize / 2.0 + currentOffset);

    // if (currentOffset + viewPortSize >= myOffsetLow &&
    //     currentOffset + viewPortSize <= myOffsetHigh) {
    //   setState(() {
    //     _translateY = betweenOffset * 0.5;
    //   });
    // }
    //
    //
    final scrollable = Scrollable.of(context);
    final scrollableRenderBox =
        scrollable.context.findRenderObject() as RenderBox;
    final myRenderBox = context.findRenderObject() as RenderBox;

    final localToGloabl = myRenderBox.localToGlobal(
        myRenderBox.size.topLeft(Offset.zero),
        ancestor: scrollableRenderBox);
    final scrollFraction =
        (localToGloabl.dy / scrollable.position.viewportDimension)
            .clamp(-1.0, 1.0);

    setState(() {
      _translateY = scrollFraction;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(_translateY);
    return Stack(
      children: [
        Align(
          alignment: Alignment(0.0, (-_translateY * 3).clamp(-1.0, 1.0)),
          child: Image.asset(
            'moon.jpeg',
            height: size.height / 2.0,
            fit: BoxFit.fitHeight,
          ),
        ),

        // Container(
        //   height: 1000,
        //   width: 1390,
        //   child: FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: Image.asset(
        //       'moon.jpeg',
        //     ),
        //   ),
        // )
      ],
    );
  }
}
