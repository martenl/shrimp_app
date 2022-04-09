import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Configuration.dart';
import 'package:shrimp_app/models/Dimension.dart';
import 'package:shrimp_app/widgets/ConfigurationInput.dart';
import 'package:shrimp_app/widgets/DimensionInput.dart';

class PondSettingsPage extends StatefulWidget {
  @override
  _PondSettingsState createState() => _PondSettingsState();
}

class _PondSettingsState extends State<PondSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Expanded(
            child: Column(children: <Widget>[
      ConfigurationInput(configuration: Configuration('Test pond 1', 20.0)),
      Divider(
        height: 2.0,
      ),
      DimensionInput(
          dimension:
              PondDimension(10.0, 15.0, 5.0, Shape.rectangle, Slope.slanted))
    ])));
  }
}
