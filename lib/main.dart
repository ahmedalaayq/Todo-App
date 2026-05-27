import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/datasource/file_storage_manager.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/on_generate_route.dart';
import 'package:todo_app/core/theme/light_theme.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/generated/l10n.dart';
import 'core/theme/dark_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await PreferenceManager.init();
  await FileStorageManager().init();
  final welcomeSeen = PreferenceManager.getData<bool?>(StorageKey.welcome) ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeManager()..init(),
          child: MyApp(welcomeSeen: welcomeSeen),
        ),
        ChangeNotifierProvider(create: (context) => MainController()..init()),
      ],
      child: MyApp(welcomeSeen: welcomeSeen),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.welcomeSeen});

  final bool welcomeSeen;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>();

    return ScreenUtilInit(
      designSize: const Size(375, 809),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Todo',

          locale: const Locale('ar'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: theme.themeMode,

          onGenerateRoute: onGenerateRoute,
          initialRoute: welcomeSeen
              ? AppRoutes.splashView
              : AppRoutes.welcomeView,
        );
      },
    );
  }
}
