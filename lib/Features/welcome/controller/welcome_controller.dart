import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/views/main_view.dart';
import 'package:todo_app/core/datasource/storage_key.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';

class WelcomeController with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  late SharedPreferences _prefs;
  List<Task> tasks = [];

  bool isButtonActive = false;

  void init() {
    // fetchTasks();
    nameController.addListener(() {
      isButtonActive = nameController.text.trim().isNotEmpty;
    });
    notifyListeners();
  }

  // Future<void> fetchTasks() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   final taskJson = _prefs.getString(StorageKey.tasks);
  //   if (taskJson != null) {
  //     final decoded = jsonDecode(taskJson) as List<dynamic>;
  //     tasks = decoded.map((e) => Task.fromJson(e)).toList();
  //   }
  //   notifyListeners();
  // }

  Future<void> saveUserData(BuildContext context) async {
    await _prefs.setBool('welcome', true);
    await _prefs.setString('username', nameController.text.trim());
    if (!context.mounted) return;
    context.pushReplacement(MainView(tasks: tasks));
  }
}
