import 'package:flutter/material.dart';
import 'package:todo_app/Features/welcome/views/welcome_view.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/no_route_found.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeView:
      return MaterialPageRoute(builder: (context) => WelcomeView());

    default:
      return MaterialPageRoute(
        builder: (context) => NoRouteFoundView(routeName: settings.name ?? ""),
      );
  }
}
