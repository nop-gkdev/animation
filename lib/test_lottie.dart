import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class Test_Lottie extends StatefulWidget {
  const Test_Lottie({super.key});

  @override
  State<Test_Lottie> createState() => _Test_LottieState();
}

class _Test_LottieState extends State<Test_Lottie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Stack(children: [
              Container(
                width: 200,
                height: 200,
                color: Color.fromARGB(255, 233, 153, 153),
                // color: Colors.transparent,
                child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_ivkcnznz.json",
                  animate: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 90, 0, 0),
                child: Text(
                  'Test',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
