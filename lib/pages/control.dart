import 'package:flutter/material.dart';
import 'package:shrimp_app/widgets/Aerator.dart';

class ControlPage extends StatefulWidget {
  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  var _selectedAutomationlevel = [true, false, false];

  void selectAutomationLevel(int index) {
    for (int i = 0; i < _selectedAutomationlevel.length; i++) {
      _selectedAutomationlevel[i] = index == i;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          ToggleButtons(
            children: [
              Text('Manual'),
              Text('Partial Automation'),
              Text('Auto')
            ],
            isSelected: _selectedAutomationlevel,
            onPressed: selectAutomationLevel,
          ),
          Aerator()
        ]));
  }
}
