import 'package:flutter/material.dart';
import 'package:shrimp_app/models/Pond.dart';
import 'package:shrimp_app/pages/pondDetails.dart';
import 'package:shrimp_app/routes.dart';
import 'package:shrimp_app/services/LocalPondService.dart';
import 'package:shrimp_app/services/RestPondService.dart';
import 'package:shrimp_app/widgets/PondListItem.dart';

class PondListPage extends StatelessWidget {
  static const String routeName = '/pondList';


  void _gotoNewPond(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.createPond);
  }

  void _gotoPondDetails(BuildContext context, String pondId) {
    Navigator.of(context).pushNamed(Routes.pondDetails, arguments: PondDetailsPageArguments(pondId));
  }

  void _onTap(int index) {}

  Future<Iterable<Pond>> getPonds() async {
    return RestPondService.getPondService().getPonds(0);
    //return LocalPondService.getPondService().getPonds(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your ponds")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<Iterable<Pond>>(
                future: getPonds(),
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return Text('Loading ponds ....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            Pond pond = snapshot.data!.elementAt(index);
                            return PondListItem(pond);
                          },
                        );
                    }
                },
              )
            ]
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Farm'),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), label: 'Settings')
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: _onTap,
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () => _gotoNewPond(context),
        tooltip: 'Add Pond',
        child: Icon(Icons.add),
      ),
    );
  }


}