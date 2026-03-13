import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/views/high_priority.dart';
import 'package:todo_app/Features/home/views/widgets/add_task_view.dart';
import 'package:todo_app/Features/splash/views/splash_view.dart';
import 'package:todo_app/Features/welcome/views/welcome_view.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/no_route_found.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeView:
      return MaterialPageRoute(builder: (context) => WelcomeView());
    case AppRoutes.splashView:
      return MaterialPageRoute(builder: (context) => SplashView());
    case AppRoutes.addTaskView:
      return MaterialPageRoute(builder: (context) => AddTaskView());

    default:
      return MaterialPageRoute(
        builder: (context) => NoRouteFoundView(routeName: settings.name ?? ""),
      );
  }
}
