import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(chart4());

class chart4 extends StatelessWidget {
  const chart4({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bar Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bidang Peminatan Statistic'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 750, // Lebar kotak latar belakang
              height: 400, // Tinggi kotak latar belakang
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 700, // Lebar grafik
                  height: 350, // Tinggi grafik
                  child: BarChart(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data generation
    final data1 = [
      OrdinalSales('Semester 1', 90),
      OrdinalSales('Semester 2', 85),
      OrdinalSales('Semester 3', 75),
      OrdinalSales('Semester 4', 80),
      OrdinalSales('Semester 5', 70),
      OrdinalSales('Semester 6', 88),
      OrdinalSales('Semester 7', 77),
    ];

    final data2 = [
      OrdinalSales('Semester 1', 75),
      OrdinalSales('Semester 2', 80),
      OrdinalSales('Semester 3', 65),
      OrdinalSales('Semester 4', 88),
      OrdinalSales('Semester 5', 78),
      OrdinalSales('Semester 6', 70),
      OrdinalSales('Semester 7', 82),
    ];

    final data3 = [
      OrdinalSales('Semester 1', 70),
      OrdinalSales('Semester 2', 78),
      OrdinalSales('Semester 3', 90),
      OrdinalSales('Semester 4', 85),
      OrdinalSales('Semester 5', 75),
      OrdinalSales('Semester 6', 80),
      OrdinalSales('Semester 7', 79),
    ];

    // Series creation
    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Pemrograman Web & Mobile',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: data1,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Keamanan Jaringan',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: data2,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Manajemen Informasi',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: data3,
      ),
    ];

    // Chart creation
    return charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig<String>(
        maxBarWidthPx: 20,
        barGroupInnerPaddingPx: 5,
      ),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          cellPadding: EdgeInsets.all(23),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontSize: 14,
          ),
        ),
      ],
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: charts.MaterialPalette.black,
          ),
        ),
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          // Menyediakan tick pada nilai 10, 20, 30, dst.
          <charts.TickSpec<num>>[
            charts.TickSpec<num>(0),
            charts.TickSpec<num>(10),
            charts.TickSpec<num>(20),
            charts.TickSpec<num>(30),
            charts.TickSpec<num>(40),
            charts.TickSpec<num>(50),
            charts.TickSpec<num>(60),
            charts.TickSpec<num>(70),
            charts.TickSpec<num>(80),
            charts.TickSpec<num>(90),
            charts.TickSpec<num>(100),
          ],
        ),
      ),
    );
  }
}

class OrdinalSales {
  final String semester;
  final int value;

  OrdinalSales(this.semester, this.value);
}
