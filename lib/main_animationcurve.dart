import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintLayerBordersEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static final linearTween = Tween<double>(begin: 0, end: 1);

  static final tweenSequence = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.22)
            // .chain(CurveTween(curve: Curves.easeOut)),
            .chain(CurveTween(curve: Curves.linear)),
        weight: 370.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.22, end: 0.311)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 800,
      ),
    ],
  );

  static final tweenSequence2 = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.52)
            // .chain(CurveTween(curve: Curves.easeOut)),
            .chain(CurveTween(curve: Curves.linear)),
        weight: 370.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.52, end: 0.311)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 800,
      ),
    ],
  );

  static final Tween<double> chainTween = Tween<double>(begin: 0, end: 2);
  static final constantTween = ConstantTween<double>(1.0);
  static const Curve sawToothCurve = SawTooth(7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          AnimationAndCurveDemo(
            lable: 'Custom Curve: Springy',
            mainCurve: tweenSequence,
            kindOfAnim: KindOfAnimation.reverse,
          ),
          AnimationAndCurveDemo(
            lable: 'Custom Curve: Springy',
            mainCurve: tweenSequence,
            kindOfAnim: KindOfAnimation.reverse,
          ),
        ]),
      ),
    );
  }
}

class CustomTweenExample extends Tween<double> {
  CustomTweenExample({
    required double begin,
    required double end,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    // return super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);
    final middle = (end! - begin!) / 2;
    if (t < 0.2) {
      return super.lerp(begin!);
    } else if (t < 0.4) {
      return super.lerp(middle);
    } else if (t < 0.6) {
      return super.lerp(end!);
    } else if (t < 0.8) {
      return super.lerp(middle);
    }
    return super.lerp(end!);
  }
}

// class SineCurve extends Curve {
//   const SineCurve({this.count = 3});

//   final double count;

//   // t = x
//   @override
//   double transformInternal(double t) {
//     var val = sin(count * 2 * pi * t) * 0.5 + 0.5 + 0.5;
//     // var val = sin(2 * pi * t);
//     return val; //f(x)
//   }
// }

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.29,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

enum KindOfAnimation {
  forward,
  repeat,
  repeatAndreverse,
  reverse,
}

class AnimationAndCurveDemo extends StatefulWidget {
  const AnimationAndCurveDemo({
    Key? key,
    required this.mainCurve,
    // required this.mainCurve2,
    this.compareCurve,
    this.lable = '',
    this.size = 290,
    this.size2 = 400,
    this.duration = const Duration(seconds: 3),
    this.duration2 = const Duration(seconds: 3),
    this.kindOfAnim = KindOfAnimation.repeat,
  }) : super(key: key);

  final Animatable<double> mainCurve;
  // final Animatable<double> mainCurve2;
  final Animatable<double>? compareCurve;
  final String lable;
  final double size;
  final double size2;
  final Duration duration;
  final Duration duration2;
  final KindOfAnimation kindOfAnim;

  @override
  _AnimationAndCurveDemoState createState() => _AnimationAndCurveDemoState();
}

class _AnimationAndCurveDemoState extends State<AnimationAndCurveDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller, _controller2;

  Animatable<double> get _mainCurve => widget.mainCurve;
  // Animatable<double> get _mainCurve2 => widget.mainCurve2;
  Animatable<double>? get _compareCurve => widget.compareCurve;
  String get _label => widget.lable;
  double get _size => widget.size;
  double get _size2 => widget.size2;
  Duration get _duration => widget.duration;
  Duration get _duration2 => widget.duration2;
  KindOfAnimation get _kindOfAnim => widget.kindOfAnim;

  late Path _shadowPath;
  Path? _comparePath;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _shadowPath = _buildGraph(_mainCurve);
    if (_compareCurve != null) {
      _comparePath = _buildGraph(_compareCurve!);
    }
    _playAnimation();
  }

  Path _buildGraph(Animatable<double> animatable) {
    var val = 0.0;
    var path = Path();
    for (var t = 0.0; t <= 1; t += 0.01) {
      val = -animatable.transform(t) * _size;
      path.lineTo(t * _size, val);
    }
    return path;
  }

  void _playAnimation() {
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var intervalValue = 0.0;
    var followPath = Path();
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: heightDevice * 0,
              bottom: 255,
              left: widthDevice * 0,
              right: widthDevice * 0,
              child: Image(
                image: AssetImage("img/sky.png"),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: heightDevice * 0.2,
              bottom: 95,
              left: widthDevice * 0,
              right: widthDevice * 0,
              child: Image(
                image: AssetImage("img/house_solar_roof.png"),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: heightDevice * -0.123,
              bottom: 5,
              left: widthDevice * 0.225,
              right: widthDevice * -0.08,
              child: new ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: heightDevice / 2,
                  ),
                  Container(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        if (intervalValue >= _controller.value) {
                          followPath.reset();
                        }
                        intervalValue = _controller.value;

                        final val = _mainCurve.evaluate(_controller);
                        followPath.lineTo(
                            _controller.value * _size, -val * _size);

                        return CustomPaint(
                          painter: GraphPainter(
                            shadowPath: _shadowPath,
                            followPath: followPath,
                            comparePath: _comparePath,
                            currentPoint: Offset(
                              _controller.value * _size,
                              val * _size,
                            ),
                            graphSize: _size,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: heightDevice * -0.423,
              bottom: 5,
              left: widthDevice * 0.225,
              right: widthDevice * -0.08,
              child: new ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: heightDevice / 2,
                  ),
                  Container(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        // intervalValue = _controller.value;

                        final val = _mainCurve.evaluate(_controller);
                        followPath.lineTo(
                            _controller.value * _size, -val * _size);

                        return CustomPaint(
                          painter: GraphPainter(
                            shadowPath: _shadowPath,
                            followPath: followPath,
                            comparePath: _comparePath,
                            currentPoint: Offset(
                              _controller.value * _size,
                              val * _size,
                            ),
                            graphSize: _size,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
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
    ..color = Color.fromARGB(255, 243, 239, 239);
  static final currentPointPaint = Paint()
    ..color = Color.fromARGB(255, 13, 125, 45);
  static final shadowPaint = Paint()
    ..color = Color.fromARGB(255, 10, 128, 118)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  static final followPaint = Paint()
    ..color = Color.fromARGB(255, 3, 147, 149)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

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
