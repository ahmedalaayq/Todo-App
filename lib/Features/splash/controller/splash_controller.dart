import 'package:flutter/material.dart';
import 'package:todo_app/Features/main/views/main_view.dart';

class SplashController with ChangeNotifier {
  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainView(),
      ),
    );
  }
}
