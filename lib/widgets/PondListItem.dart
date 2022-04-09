

import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Measurement.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/pages/pondDetails.dart';

import '../routes.dart';

class PondListItem extends StatelessWidget {

  final Pond pond;
  PondListItem(this.pond);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(),
        child: ListTile(
            title: Text(pond.configuration.name),
            subtitle: MeasurementItem(measurement: pond.lastMeasurement),
            onTap: () => Navigator.of(context).pushNamed(Routes.pondDetails, arguments: PondDetailsPageArguments(pond.id))
        )
    );
  }

}

class MeasurementItem extends StatelessWidget {
  final Measurement measurement;

  const MeasurementItem({Key? key, required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Icon(Icons.thermostat),
        Text('${measurement.temperature} °C'),
        Text('pH: ${measurement.ph}'),
        Text('Oxygen saturation: ${measurement.oxygenSaturation}'),
      ]
    );
  }

}