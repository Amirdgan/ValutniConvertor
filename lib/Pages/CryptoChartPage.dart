import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CryptoChartPage extends StatelessWidget {
  final String title;

  CryptoChartPage({required this.title});

  List<PricePoint> getDataForCurrency(String name) {
    switch (name) {
      case 'USD':
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 83.5),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 81.0),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 82.8),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 80.2),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 79.9),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 77.1),
          PricePoint(DateTime.now(), 75.3),
        ];
      case 'EUR':
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 86.2),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 86.5),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 86.3),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 86.7),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 86.4),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 86.6),
          PricePoint(DateTime.now(), 86.8),
        ];
      case 'GBP':
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 101.5),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 101.8),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 101.7),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 102.0),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 101.9),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 102.1),
          PricePoint(DateTime.now(), 102.3),
        ];
      case 'BTC':
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 45000),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 45500),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 45200),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 45800),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 46000),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 46200),
          PricePoint(DateTime.now(), 46500),
        ];
      case 'ETH':
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 3000),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 3050),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 3020),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 3080),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 3100),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 3120),
          PricePoint(DateTime.now(), 3150),
        ];
      default:
        return [
          PricePoint(DateTime.now().subtract(Duration(days: 6)), 0),
          PricePoint(DateTime.now().subtract(Duration(days: 5)), 0),
          PricePoint(DateTime.now().subtract(Duration(days: 4)), 0),
          PricePoint(DateTime.now().subtract(Duration(days: 3)), 0),
          PricePoint(DateTime.now().subtract(Duration(days: 2)), 0),
          PricePoint(DateTime.now().subtract(Duration(days: 1)), 0),
          PricePoint(DateTime.now(), 0),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = getDataForCurrency(title);

    final seriesList = [
      charts.Series<PricePoint, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PricePoint point, _) => point.time,
        measureFn: (PricePoint point, _) => point.price,
        data: data,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$title График'),
        backgroundColor: Colors.indigo[400],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        child: charts.TimeSeriesChart(
          seriesList,
          animate: true,
          defaultRenderer: charts.LineRendererConfig(
            includePoints: true, // показывать точки
            includeLine: true, // линия
            strokeWidthPx: 3, // толщина линии
            radiusPx: 4// сглаживание отключено, сделайте true, если версия поддерживает
          ),
          primaryMeasureAxis: charts.NumericAxisSpec(
            viewport: charts.NumericExtents(
              _getMinPrice(data) * 0.95,
              _getMaxPrice(data) * 1.05,
            ),
          ),
          domainAxis: charts.DateTimeAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontSize: 12,
                color: charts.MaterialPalette.gray.shadeDefault,
              ),
              lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shadeDefault,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getMinPrice(List<PricePoint> data) {
    return data.map((p) => p.price).reduce((a, b) => a < b ? a : b);
  }

  double _getMaxPrice(List<PricePoint> data) {
    return data.map((p) => p.price).reduce((a, b) => a > b ? a : b);
  }
}

class PricePoint {
  final DateTime time;
  final double price;

  PricePoint(this.time, this.price);
}