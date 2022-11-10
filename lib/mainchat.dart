import 'package:animation/custom_paint.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [buildChartStack()],
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }

  Widget buildChartStack() {
    return Chart<void>(
      height: 300.0,
      state: ChartState(
        data: ChartData(
          [
            [13, 6, 2, 5].map((e) => ChartItem<void>(e.toDouble())).toList(),
            [10, 5, 7, 1].map((e) => ChartItem<void>(e.toDouble())).toList(),
            [7, 2, 4, 8].map((e) => ChartItem<void>(e.toDouble())).toList(),
            [3, 4, 10, 2].map((e) => ChartItem<void>(e.toDouble())).toList(),
          ],
          axisMax: 12,
        ),
        itemOptions: WidgetItemOptions(
            widgetItemBuilder: ((item) {
              if (item.listIndex == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 10,
                    height: 20,
                    color: Color.fromARGB(255, 230, 180, 202),
                  ),
                );
              }
              if (item.listIndex == 1) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: 10,
                    height: 20,
                    color: Color.fromARGB(255, 38, 111, 41),
                  ),
                );
              }
              if (item.listIndex == 2) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: 10,
                    height: 20,
                    color: Color.fromARGB(255, 120, 141, 121),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 0, 18, 8),
                child: Container(
                  width: 5,
                  height: 10,
                  color: Colors.red,
                  // child: CustomPaint(
                  //   size: const Size(double.infinity, double.infinity),
                  //   painter: ContainerPatternPainter(),
                  // ),
                ),
              );
            }),
            multiValuePadding: EdgeInsets.all(5)),
        backgroundDecorations: [
          WidgetDecoration(
            widgetDecorationBuilder:
                (context, chartState, itemWidth, verticalMultiplayer) {
              return Container(
                color: Colors.white,
              ); // Your widget goes here
            },
            margin: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
