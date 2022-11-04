import 'package:flutter/material.dart';

class GraphPainter extends CustomPainter {
  const GraphPainter({
    required this.currentPoint,
    required this.shadowPath,
    required this.followPath,
    this.comparePath,
    required this.graphSize,
  });

  final Offset currentPoint;
  final Path shadowPath;
  final Path followPath;
  final Path? comparePath;
  final double graphSize;

  static final backgroundPaint = Paint()
    ..color = Color.fromARGB(255, 18, 123, 123);
  static final currentPointPaint = Paint()
    ..color = Color.fromARGB(255, 12, 213, 193);
  static final shadowPaint = Paint()
    ..color = Color.fromARGB(255, 18, 123, 123)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  static final followPaint = Paint()
    ..color = Color.fromARGB(255, 12, 213, 193)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    canvas.translate(
        size.width / 2 - graphSize / 2, size.height / 2 - graphSize / 2);

    canvas.translate(0, graphSize);

    canvas
      ..drawPath(shadowPath, shadowPaint)
      ..drawPath(followPath, followPaint)
      ..drawCircle(
          Offset(currentPoint.dx, -currentPoint.dy), 4, currentPointPaint);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class GraphPainter3 extends CustomPainter {
  const GraphPainter3({
    required this.currentPoint,
    required this.shadowPath,
    required this.followPath,
    this.comparePath,
    required this.graphSize,
  });

  final Offset currentPoint;
  final Path shadowPath;
  final Path followPath;
  final Path? comparePath;
  final double graphSize;

  static final backgroundPaint = Paint()
    ..color = Color.fromARGB(255, 18, 123, 123);
  static final currentPointPaint = Paint()
    ..color = Color.fromARGB(255, 230, 71, 71);
  static final shadowPaint = Paint()
    ..color = Color.fromARGB(255, 248, 70, 70)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  static final followPaint = Paint()
    ..color = Color.fromARGB(255, 12, 213, 193)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    canvas.translate(
        size.width / 2 - graphSize / 2, size.height / 2 - graphSize / 2);

    canvas.translate(0, graphSize);

    canvas
      ..drawPath(shadowPath, shadowPaint)
      ..drawPath(followPath, followPaint)
      ..drawCircle(
          Offset(currentPoint.dx, -currentPoint.dy), 4.5, currentPointPaint);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
