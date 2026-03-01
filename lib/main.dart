import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 809),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          darkTheme: .dark(),
          themeMode: .dark,
          theme: ThemeData(brightness: .dark),
          onGenerateRoute: onGenerateRoute,
          initialRoute: AppRoutes.welcomeView,
        );
      },
    );
  }
}
