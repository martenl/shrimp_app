import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Measurement.dart';

class SensorDataPage extends StatelessWidget {
  static const String routeName = '/pondList';
  final List<Measurement> measurements;

  const SensorDataPage({Key? key, this.measurements = const []}) : super(key: key);

  List<DataRow> createDataRows(List<Measurement> measurements) {
    return measurements
        .map((e) => DataRow(cells: [
              DataCell(Text("today")),
              DataCell(Text(e.oxygenSaturation.toStringAsFixed(2))),
              DataCell(Text(e.temperature.toStringAsFixed(2)))
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
          DataColumn(label: Text('Date time')),
          DataColumn(label: Text('Do')),
          DataColumn(label: Text('Temp')),
        ], rows: createDataRows(measurements));
  }
}
