import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/views/main_view.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> initApp() async {
    final pref = await SharedPreferences.getInstance();
    final String? taskJson = pref.getString('tasks');

    List<Task> tasks = [];

    if (taskJson != null) {
      final tasksListJson = jsonDecode(taskJson) as List<dynamic>;
      tasks = tasksListJson.map((e) => Task.fromJson(e)).toList();
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainView(
        tasks: tasks,
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(AssetsManager.imagesSplash));
  }
}
