import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/on_generate_route.dart';
import 'package:todo_app/core/theme/light_theme.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/generated/l10n.dart';
import 'core/theme/dark_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final welcomeSeen = prefs.getBool('welcome') ?? false;
  await PreferenceManager.init();
  ThemeManager.init();
  runApp(MyApp(welcomeSeen: welcomeSeen));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.welcomeSeen});
  final bool welcomeSeen;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 809),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      builder: (context, widget) {
        return ValueListenableBuilder(
          valueListenable: ThemeManager.themeNotifier,
          builder: (context, updatedValue, _) => MaterialApp(
            locale: Locale('ar'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Todo',
            darkTheme: darkTheme,
            themeMode: updatedValue,
            theme: lightTheme,
            onGenerateRoute: onGenerateRoute,
            initialRoute: welcomeSeen
                ? AppRoutes.splashView
                : AppRoutes.welcomeView,
          ),
        );
      },
    );
  }
}

