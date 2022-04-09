

import 'package:flutter/widgets.dart';
import 'package:shrimp_app/pages/createPond.dart';
import 'package:shrimp_app/pages/editPond.dart';
import 'package:shrimp_app/pages/pondDetails.dart';
import 'package:shrimp_app/pages/pondList.dart';

class Routes {
  static const String pondList = PondListPage.routeName;
  static const String createPond = CreatePondPage.routeName;
  static const String editPond = EditPondPage.routeName;
  static const String pondDetails = PondDetailsPage.routeName;

  static Map<String, WidgetBuilder> routes = {
    Routes.pondList: (context) => PondListPage(),
    Routes.pondDetails: (context) => PondDetailsPage(),
    Routes.createPond: (context) => CreatePondPage(),
    Routes.editPond: (context) => EditPondPage()
  };
}