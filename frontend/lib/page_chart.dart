import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'api.dart';

class ChartPage extends StatelessWidget {
  final String exerciseName, dateFrom, dateTo;
  ChartPage(this.exerciseName, this.dateFrom, this.dateTo);

  List<charts.Series<TimeSeriesWeightOrDistance, DateTime>> getData() {
    final Map<String, int> map = Api.getMap(exerciseName, dateFrom, dateTo);

    List<TimeSeriesWeightOrDistance> historicalData = [];

    map.forEach((time, value) => historicalData.add(
        new TimeSeriesWeightOrDistance(
            new DateTime(int.parse(time.split("/")[2]),
                int.parse(time.split("/")[0]), int.parse(time.split("/")[1])),
            value)));

    return [
      new charts.Series<TimeSeriesWeightOrDistance, DateTime>(
        id: 'WeightOrDistance',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWeightOrDistance data, _) => data.time,
        measureFn: (TimeSeriesWeightOrDistance data, _) =>
            data.weightOrDistance,
        data: historicalData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName +
            ": " +
            (Api.isStrength(exerciseName) ? "Weight(lb)" : "Distance(mi)")),
        backgroundColor: Colors.purple,
      ),
      body: charts.TimeSeriesChart(
        getData(),
        animate: false,
        defaultRenderer: new charts.BarRendererConfig<DateTime>(),
        defaultInteractions: false,
        behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

class TimeSeriesWeightOrDistance {
  final DateTime time;
  final int weightOrDistance;
  TimeSeriesWeightOrDistance(this.time, this.weightOrDistance);
}
