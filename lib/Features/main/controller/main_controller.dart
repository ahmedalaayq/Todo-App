import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';

class MainController with ChangeNotifier {
  int currentIndex = 0;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  double indicatorValue = 0.0;

  bool isAddTaskButtonEnabled = false;
  bool isHighPriority = false;

  bool _isInitAddTask = false;

  void initAddTask() {
    taskNameController.clear();
    taskDescriptionController.clear();
    isHighPriority = false;

    if (!_isInitAddTask) {
      taskNameController.addListener(_validateAddTask);
      taskDescriptionController.addListener(_validateAddTask);
      _isInitAddTask = true;
    }

    _validateAddTask();
  }

  void _validateAddTask() {
    isAddTaskButtonEnabled = taskNameController.text.trim().isNotEmpty;

    notifyListeners();
  }

  void toggleHighPriority(bool value) {
    isHighPriority = value;
    notifyListeners();
  }

  bool welcomeSeen = false;

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

  Future<void> submitTask(BuildContext context) async {
    final task = Task(
      taskName: taskNameController.text.trim(),
      taskDescription: taskDescriptionController.text.trim(),
      isDone: false,
      isHighPriority: isHighPriority,
    );

    await addTask(task);

    taskNameController.clear();
    taskDescriptionController.clear();
    // notifyListeners();

    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  Future<void> addTask(Task task) async {
    tasks.add(task);
    await _saveTasks();
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

  Future<void> removeTask(BuildContext context, String id) async {
    tasks.removeWhere((e) => e.id == id);
    await _saveTasks();

    if (!context.mounted) return;

    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.error.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.delete_outline, color: theme.colorScheme.error),
              const SizedBox(width: 10),
              Expanded(
                child: Text("Task removed", style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTasks() async {
    final jsonTasks = tasks.map((e) => e.toJson()).toList();

    await PreferenceManager.setData<String?>(
      StorageKey.tasks,
      jsonEncode(jsonTasks),
    );

    notifyListeners();
  }

  void onTransition(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Color getIndicatorColor() {
    if (indicatorValue >= 0.8) {
      return const Color(0xFF22C55E);
    }
    if (indicatorValue >= 0.6) {
      return const Color(0xFFFACC15);
    }
    if (indicatorValue >= 0.4) {
      return const Color(0xFFFB923C);
    }
    return const Color(0xFFEF4444);
  }
}
