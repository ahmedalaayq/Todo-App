import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/splash/controller/splash_controller.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/theme/theme_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashController>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeManager>(
        builder: (context, theme, _) {
          return Center(
            child: Image.asset(
              theme.isDark
                  ? AssetsManager.imagesSplash
                  : AssetsManager.imagesIconsSplashLight,
            ),
          );
        },
      ),
    );
  }
}