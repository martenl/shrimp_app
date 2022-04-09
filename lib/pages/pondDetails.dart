import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Measurement.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/pages/control.dart';
import 'package:shrimp_app/pages/editPond.dart';
import 'package:shrimp_app/pages/pondInfo.dart';
import 'package:shrimp_app/pages/pondSettings.dart';
import 'package:shrimp_app/pages/sensorData.dart';
import 'package:shrimp_app/services/PondService.dart';
import 'package:shrimp_app/services/LocalPondService.dart';

import '../routes.dart';

class PondDetailsPageArguments {
  final String pondId;

  PondDetailsPageArguments(this.pondId);
}

class PondDetailsPage extends StatefulWidget {
  static const String routeName = '/pondDetails';

  PondDetailsPage({Key? key}) : super(key: key);

  @override
  _PondDetailsPageState createState() => _PondDetailsPageState();
}

class _PondDetailsPageState extends State<PondDetailsPage> {
  late PondDetailsPageArguments args;
  var _selectedIndex = 0;

  var pages = [
    PondInfoPage(),
    SensorDataPage(
      measurements: [
        Measurement(23.0, 6.0, 0.01),
        Measurement(23.0, 6.0, 0.01)
      ],
    ),
    ControlPage(),
    PondSettingsPage(),
  ];

  void _gotoEditPond(BuildContext context, String pondId) {
    Navigator.of(context)
        .pushNamed(Routes.editPond, arguments: EditPondsPageArguments(pondId));
  }

  @override
  Widget build(BuildContext context) {
    args =
        ModalRoute.of(context)!.settings.arguments as PondDetailsPageArguments;

    void _onTap(int index) {
      _selectedIndex = index;
      setState(() {});
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(args.pondId),
      ),
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Show ponds'),
              onTap: () {Navigator.pop(context);_gotoEditPond(context);},
            )
          ],
        ),
      ),*/
      body: pages[_selectedIndex],
      /*Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
            Text(
              'Infos about pond with following id:${args.pondId}',
            ),
            FutureBuilder<Pond>(
                future: _getPond(),
                builder: (BuildContext context, AsyncSnapshot<Pond> snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return Text('${snapshot.data!.name}');
                  }
                }),
            Text(
              args.pondId,
              style: Theme.of(context).textTheme.headline6,
            ),
        ],
            ),
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.water), label: 'Water quality'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Control'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => _gotoEditPond(context, args.pondId),
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),*/
    );
  }

  Future<Pond>? _getPond() async {
    return getPondService().getPond(args.pondId);
  }
}
