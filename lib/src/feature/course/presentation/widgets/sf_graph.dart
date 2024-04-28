import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/common_imports.dart';

class SfGraph extends StatelessWidget with AppTheme {
  const SfGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData("Week 1", 20),
      SalesData("Week 2", 50),
      SalesData("Week 3", 75),
      SalesData("Week 4", 45),
      SalesData("Week 5", 40),
    ];
    return Container(
        decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          border: Border(
            top: BorderSide(color: clr.drawerFillColor, width: size.w1),
            bottom: BorderSide(color: clr.drawerFillColor, width: size.w1),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: clr.blackColor.withOpacity(.2))
          ],
        ),
        padding: EdgeInsets.only(left: size.w16),
        child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              labelFormat: '{value}%',
              minimum: 0,
              maximum: 100,
              interval: 25,
            ),
            series: <CartesianSeries>[
              LineSeries<SalesData, String>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  markerSettings: const MarkerSettings(isVisible: true))
            ]));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
