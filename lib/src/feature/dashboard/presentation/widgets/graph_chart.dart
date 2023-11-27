import 'package:fl_chart/fl_chart.dart';

import '../../../../core/constants/common_imports.dart';

class GraphChart extends StatefulWidget {
  const GraphChart({super.key});

  @override
  State<GraphChart> createState() => _GraphChartState();
}

class _GraphChartState extends State<GraphChart> with AppTheme {
  double maxX = 5.0;
  double maxY = 4.0;
  List<FlSpot> dynamicData = [
    const FlSpot(0, 0),
    const FlSpot(1.5, 3),
    const FlSpot(2.5, 0),
    const FlSpot(5, 4),
  ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: EdgeInsets.only(right: size.w16),
        child: LineChart(mainData()),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final TextStyle style = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size.textXXSmall,
        fontFamily: StringData.fontFamilyInter,
        color: clr.textColorBlack);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ ১', style: style),
          ],
        );
        break;
      case 2:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ ২', style: style),
          ],
        );
        break;
      case 3:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ ৩', style: style),
          ],
        );
        break;
      case 4:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ ৪', style: style),
          ],
        );
        break;
      case 5:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ 5', style: style),
          ],
        );
        break;
      case 6:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 9.h,
              width: 1.w,
            ),
            Text('সপ্তাহ 6', style: style),
          ],
        );
        break;
      case 7:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 8.h,
              width: 1.w,
            ),
            Text('সপ্তাহ 7', style: style),
          ],
        );
        break;
      case 8:
        text = Column(
          children: [
            Container(
              color: clr.textColorAppleBlack,
              height: 8.h,
              width: 1.w,
            ),
            Text('সপ্তাহ 8', style: style),
          ],
        );
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final TextStyle style = TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: size.textXXSmall,
        fontFamily: StringData.fontFamilyInter,
        color: clr.textColorBlack,
        fontStyle: FontStyle.italic);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '০%';
        break;
      case 1:
        text = '২৫%';
        break;
      case 2:
        text = '৫০%';
        break;
      case 3:
        text = '৭৫%';
      case 4:
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
              color: clr.placeHolderTextColorGray,
              strokeWidth: 1,
              dashArray: [2, 3]);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
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
        border: Border.all(color: clr.placeHolderTextColorGray),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: maxY,
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
