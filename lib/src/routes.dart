import 'package:corona_trac_helper/src/ui/home/dashboard/screens/corona_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:corona_trac_helper/src/route/custom_material_page_route.dart';

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CoronaHomeScreen.ROUTE_NAME:
        return _navigate(CoronaHomeScreen(), settings);
    }
    return null;
  }
}

_navigate(Widget child, RouteSettings settings) {
  return CustomMaterialPageRoute(
      settings: settings,
      builder: (context) {
        return child;
      });
}
