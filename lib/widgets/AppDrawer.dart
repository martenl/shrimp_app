import 'package:flutter/material.dart';

import '../routes.dart';

class AppDrawer extends StatelessWidget {

  void _goTo(BuildContext context, String route) {
    Navigator.of(context).popAndPushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Image(image: AssetImage('images/shrimp.png'))),
          ListTile(
            title: const Text('Show ponds'),
            onTap: () => _goTo(context,Routes.pondList),
          ),
          Divider(),
          ListTile(
            title: const Text('Add new pond'),
            onTap: () => _goTo(context,Routes.createPond),
          ),
        ],
      ),
    );
  }

}