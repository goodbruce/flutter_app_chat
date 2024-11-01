import 'package:flutter/material.dart';

class ChatBubbleMenuShape extends CustomPainter {
  final Color bgColor;
  final double arrowSize;

  ChatBubbleMenuShape(this.bgColor, this.arrowSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-arrowSize, 0);
    path.lineTo(0, arrowSize);
    path.lineTo(arrowSize, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}