import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';

class MainController with ChangeNotifier {
  int currentIndex = 0;

  bool welcomeSeen = false;
  bool isLoading = false;

  String userName = 'Guest';
  String motivationQuote = '';
  String userImagePath = '';

  List<Task> tasks = [];

  void init() {
    loadTasks();
    fetchUserData();
  }

  void fetchUserData() {
    userName =
        PreferenceManager.getData<String?>(StorageKey.username) ?? "Guest";
    motivationQuote =
        PreferenceManager.getData<String?>(StorageKey.motivationQuote) ?? "";
    welcomeSeen = PreferenceManager.getData<bool?>(StorageKey.welcome) ?? false;
    userImagePath =
        PreferenceManager.getData<String?>(StorageKey.userImagePath) ?? "";

    log("userName: $userName");
    log("quote: $motivationQuote");

    notifyListeners();
  }

  Future<void> updateUserImage(String path) async {
    userImagePath = path;

    await PreferenceManager.setData<String>(StorageKey.userImagePath, path);

    notifyListeners();
  }

  Future<void> updateUserData(String name, String quote) async {
    userName = name;
    motivationQuote = quote;

    await PreferenceManager.setData<String?>(StorageKey.username, name);
    await PreferenceManager.setData<String?>(StorageKey.motivationQuote, quote);

    notifyListeners();
  }

  void loadTasks() {
    final taskJson = PreferenceManager.getData<String?>(StorageKey.tasks);

    if (taskJson != null) {
      final list = jsonDecode(taskJson) as List<dynamic>;
      tasks = list.map((e) => Task.fromJson(e)).toList();
    }

    notifyListeners();
  }

  Future<void> checkTask(Task task, bool value) async {
    task.isDone = value;
    await _saveTasks();
  }

  Future<void> _saveTasks() async {
    final jsonTasks = tasks.map((e) => e.toJson()).toList();

    await PreferenceManager.setData<String?>(
      StorageKey.tasks,
      jsonEncode(jsonTasks),
    );

    notifyListeners();
  }

  Future<void> removeTask(BuildContext context, String id) async {
    tasks.removeWhere((e) => e.id == id);

    await _saveTasks();

    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Task removed")));
  }

  void onTransition(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool getAppTheme() {
    return PreferenceManager.getData<bool>(StorageKey.theme) ?? false;
  }
}
