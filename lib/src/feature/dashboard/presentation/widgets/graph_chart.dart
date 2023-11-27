import 'package:demo/src/core/constants/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> with AppTheme {
  List<FlSpot> dynamicData = [
    const FlSpot(0, 0),
    const FlSpot(2, 7),
    const FlSpot(4, 0),
    const FlSpot(7, 9),
    const FlSpot(8, 9),
    const FlSpot(9, 10),
    const FlSpot(9, 11),
    const FlSpot(11, 11),
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: EdgeInsets.only(right: size.w16),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Column(
          children: [
            Container(
              color: Colors.black,
              height: 8.h,
              width: 1.w,
            ),
            const Text('সপ্তাহ ১', style: style),
          ],
        );
        break;
      case 4:
        text = Column(
          children: [
            Container(
              color: Colors.black,
              height: 8.h,
              width: 1.w,
            ),
            const Text('সপ্তাহ ২', style: style),
          ],
        );
        break;
      case 7:
        text = Column(
          children: [
            Container(
              color: Colors.black,
              height: 8.h,
              width: 1.w,
            ),
            const Text('সপ্তাহ ৩', style: style),
          ],
        );
        break;
      case 9:
        text = Column(
          children: [
            Container(
              color: Colors.black,
              height: 8.h,
              width: 1.w,
            ),
            const Text('সপ্তাহ ৪', style: style),
          ],
        );
        break;
      case 11:
        text = Column(
          children: [
            Container(
              color: Colors.black,
              height: 8.h,
              width: 1.w,
            ),
            const Text('সপ্তাহ 5', style: style),
          ],
        );
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '০%';
        break;
      case 3:
        text = '২৫%';
        break;
      case 6:
        text = '৫০%';
        break;
      case 8:
        text = '৭৫%';
      case 11:
        text = '১০০%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: Colors.grey.withOpacity(.2),
              strokeWidth: 1,
              dashArray: [1, 2]);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0x2f37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: dynamicData,
          isCurved: false,
          color: clr.cardStrokeColorHint,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: clr.cardStrokeColor,
          ),
        ),
      ],
    );
  }
}
