import 'package:animation/test_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'animations/graph_painter.dart';
// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintLayerBordersEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Test_Lottie(),
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
        tween: Tween<double>(begin: 0, end: 0.20)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 350.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.20, end: 0.29)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 800,
      ),
    ],
  );

  static final tweenSequence2 = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.0)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 0.01,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.06, end: 0.146)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 3900,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.146, end: 0.211)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 12300,
      ),
    ],
  );

  static final tweenSequence3 = TweenSequence(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.01, end: 0.01)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 0.01,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.29, end: -0.515)
            .chain(CurveTween(curve: Curves.easeOutCirc)),
        weight: 2.22,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.515, end: -0.515)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 10.0,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // return OrientationBuilder(builder: (context, orientation))
    return Scaffold(
      body: Center(
        child: Stack(children: [
          AnimationAndCurveDemo(
            lable: 'Custom Curve: Springy',
            mainCurve: tweenSequence,
            mainCurve2: tweenSequence2,
            mainCurve3: tweenSequence3,
          ),
        ]),
      ),
    );
  }
}

class AnimationAndCurveDemo extends StatefulWidget {
  const AnimationAndCurveDemo({
    Key? key,
    required this.mainCurve,
    required this.mainCurve2,
    required this.mainCurve3,
    this.compareCurve,
    this.compareCurve2,
    this.compareCurve3,
    this.lable = '',
    this.size = 290,
    this.size3 = 160,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  final Animatable<double> mainCurve;
  final Animatable<double> mainCurve2;
  final Animatable<double> mainCurve3;
  final Animatable<double>? compareCurve;
  final Animatable<double>? compareCurve2;
  final Animatable<double>? compareCurve3;
  final String lable;
  final double size;
  final double size3;
  final Duration duration;

  @override
  _AnimationAndCurveDemoState createState() => _AnimationAndCurveDemoState();
}

class _AnimationAndCurveDemoState extends State<AnimationAndCurveDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animatable<double> get _mainCurve => widget.mainCurve;
  Animatable<double> get _mainCurve2 => widget.mainCurve2;
  Animatable<double> get _mainCurve3 => widget.mainCurve3;
  Animatable<double>? get _compareCurve => widget.compareCurve;
  Animatable<double>? get _compareCurve2 => widget.compareCurve2;
  Animatable<double>? get _compareCurve3 => widget.compareCurve3;
  double get _size => widget.size;
  double get _size3 => widget.size3;
  Duration get _duration => widget.duration;

  late Path _shadowPath;
  late Path _shadowPath2;
  late Path _shadowPath3;

  Path? _comparePath;
  Path? _comparePath2;
  Path? _comparePath3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _shadowPath = _buildGraph(_mainCurve);
    _shadowPath2 = _buildGraph2(_mainCurve2);
    _shadowPath3 = _buildGraph3(_mainCurve3);

    if (_compareCurve != null) {
      _comparePath = _buildGraph(_compareCurve!);
    }
    if (_compareCurve2 != null) {
      _comparePath2 = _buildGraph2(_compareCurve2!);
    }
    if (_compareCurve3 != null) {
      _comparePath3 = _buildGraph3(_compareCurve3!);
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

  Path _buildGraph2(Animatable<double> animatable) {
    var val = 0.0;
    var path = Path();
    for (var t = 0.0; t <= 1; t += 0.01) {
      val = -animatable.transform(t) * -_size;
      path.lineTo(t * -_size, val);
    }
    return path;
  }

  Path _buildGraph3(Animatable<double> animatable) {
    var val = 0.0;
    var path = Path();
    for (var t = 0.0; t <= 1; t += 0.01) {
      val = -animatable.transform(t) * _size3;
      path.lineTo(t * _size3, val);
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
    // ignore: unused_local_variable
    var intervalValue = 0.0;
    var followPath = Path();
    var followPath3 = Path();
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;
    var testhe = heightDevice / 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 170, 250, 0),
                  child: Image(
                    image: AssetImage("img/electric_pole.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
                  child: Image(
                    image: AssetImage("img/grass_fence.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child: Image(
                    image: AssetImage("img/house_solar_roof.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(275, 195, 0, 0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      intervalValue = _controller.value;
                      // followPath.reset();
                      final val = _mainCurve.evaluate(_controller);
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
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(560, 135, 0, 0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      final val = _mainCurve2.evaluate(_controller);
                      // followPath.lineTo(
                      //     _controller.value * -_size, val * -_size);
                      return CustomPaint(
                        painter: GraphPainter(
                          shadowPath: _shadowPath2,
                          followPath: followPath,
                          comparePath: _comparePath,
                          currentPoint: Offset(
                            _controller.value * -_size,
                            val * -_size,
                          ),
                          graphSize: _size,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(166, 310, 0, 0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      intervalValue = _controller.value;
                      final val = _mainCurve3.evaluate(_controller);
                      return CustomPaint(
                        painter: GraphPainter3(
                          shadowPath: _shadowPath3,
                          followPath: followPath3,
                          comparePath: _comparePath,
                          currentPoint: Offset(
                            _controller.value * _size3,
                            val * _size3,
                          ),
                          graphSize: _size3,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Container(
              //   child: Lottie.network(
              //       "https://assets7.lottiefiles.com/packages/lf20_5ugmbg9n.json"),
              // ),
            ],
          ),
        ],
      ),
    );
    // });
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double left = MediaQuery.of(context).padding.left;
    double right = MediaQuery.of(context).padding.right;

    double side = height * 0.10;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 170, 230, 0),
                  child: Image(
                    image: AssetImage("img/electric_pole.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child: Image(
                    image: AssetImage("img/house_solar_roof.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
