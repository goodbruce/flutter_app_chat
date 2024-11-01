import 'package:flutter/cupertino.dart';

class MyScrollPhysics extends BouncingScrollPhysics {
  const MyScrollPhysics({ ScrollPhysics? parent }) : super(parent: parent);

  @override
  MyScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MyScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    return newPosition.pixels;
  }
}