import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';

class MainController with ChangeNotifier {
  List<Task> tasks = [];

  MainController() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    final taskJson = pref.getString('tasks');

    if (taskJson != null) {
      final tasksListJson = jsonDecode(taskJson) as List<dynamic>;
      tasks = tasksListJson.map((e) => Task.fromJson(e)).toList();
    }
    notifyListeners();
  }

  Future<void> checkTask(Task task, bool value) async {
    task.isDone = value;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> removeTask(String id) async {
    final removedTask = tasks.firstWhere((t) => t.id == id);
    tasks.removeWhere((t) => t.id == id);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final pref = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => e.toJson()).toList();
    await pref.setString('tasks', jsonEncode(jsonTasks));
  }
}