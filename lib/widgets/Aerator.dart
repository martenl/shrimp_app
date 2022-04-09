import 'package:flutter/material.dart';

class Aerator extends StatefulWidget {
  @override
  _AeratorState createState() => _AeratorState();
}

class _AeratorState extends State<Aerator> {
  @override
  Widget build(BuildContext context) {
    return Card(child:ListTile(
      title:Text('Aerator group'),
      subtitle: Padding(
        padding: EdgeInsets.all(10),
        child:Row(children: [
          Column(children: [Icon(Icons.waves), Text("Stream")]),
          Column(children: [Icon(Icons.support), Text("Support")]),
          Column(children: [Icon(Icons.calendar_today_rounded), Text("Schedule")]),
          Column(children: [Icon(Icons.waves), Text("Sludge")]),
          Column(children: [Icon(Icons.bolt_outlined), Text("Off")]),
        ]),
      )
    ));
  }
}
