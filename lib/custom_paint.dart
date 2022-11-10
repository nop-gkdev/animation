import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class ContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DiagonalStripesLight(
            bgColor: Color.fromARGB(255, 247, 233, 216),
            fgColor: Color(0XFFF8A13F))
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
