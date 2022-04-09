import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/AppDrawer.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: AppDrawer(),
        body: Center(
            child: Column(children: <Widget>[

          Divider(
            height: 2.0,
          ),
        ])));
  }
}
