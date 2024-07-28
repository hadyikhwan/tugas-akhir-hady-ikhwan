import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartWidget extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        BarSeries<Map<String, dynamic>, String>(
          dataSource: <Map<String, dynamic>>[
            {'label': 'A', 'value': 10},
            {'label': 'B', 'value': 20},
            {'label': 'C', 'value': 15},
            {'label': 'D', 'value': 25},
          ],
          xValueMapper: (Map<String, dynamic> data, _) => data['label'],
          yValueMapper: (Map<String, dynamic> data, _) => data['value'],
        ),
      ],
    );
  }
}