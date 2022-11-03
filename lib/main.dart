import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Line animation'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Row(
                children: [
                  Container(
                    child: SizedBox(
                      height: 180,
                      width: 250,
                      child: Line(),
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      height: 180,
                      width: 0,
                      child: Line(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Line extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LinePainter(_progress));
  }
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  double _progress;

  LinePainter(this._progress) {
    _paint = Paint()
      ..color = const Color.fromARGB(255, 35, 124, 214)
      ..strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        const Offset(0.0, 0.0),
        Offset(size.width - size.width * _progress,
            size.height - size.height * _progress),
        _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
