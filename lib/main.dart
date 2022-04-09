import 'package:flutter/material.dart';
import 'package:shrimp_app/pages/createPond.dart';
import 'package:shrimp_app/pages/editPond.dart';
import 'package:shrimp_app/pages/pondDetails.dart';
import 'package:shrimp_app/routes.dart';
import 'pages/pondList.dart';
import 'widgets/AppDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Shrimp Demo App'),
      routes: Routes.routes,/*{
        Routes.pondList : (context) => PondListPage(),
        Routes.pondDetails: (context) => PondDetailsPage(),
        Routes.createPond : (context) => CreatePondPage(),
        Routes.editPond : (context) => EditPondPage()
      },*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter+=2;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter=0;
    });
  }

  void _gotoPonds(BuildContext context) {
    Navigator.of(context).popAndPushNamed(Routes.pondList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
            OutlinedButton(onPressed: _resetCounter, child: Text("Reset counter")),
            OutlinedButton(onPressed: () => _gotoPonds(context), child: Text("To the second route"))
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

