import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/home/views/completed_tasks.dart';
import 'package:todo_app/Features/home/views/home_view.dart';
import 'package:todo_app/Features/home/views/todo_tasks.dart';
import 'package:todo_app/Features/profile/views/profile_view.dart';
import 'widgets/custom_bottom_navbar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    final taskJson = pref.getString('tasks');

    if (taskJson != null) {
      final tasksListJson = jsonDecode(taskJson) as List<dynamic>;
      tasks = tasksListJson.map((e) => Task.fromJson(e)).toList();
    }

    setState(() {});
  }

  Future<void> checkTask(Task task, bool value) async {
    task.isDone = value;

    final pref = await SharedPreferences.getInstance();
    final jsonTasks = tasks.map((e) => e.toJson()).toList();
    await pref.setString('tasks', jsonEncode(jsonTasks));

    setState(() {});
  }

  Future<void> removeTask(String id) async {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF500000),
        content: Row(
          children: [
            Expanded(
              child: Text(
                'Task with id: $id was removed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Icon(Icons.warning, color: Colors.white),
          ],
        ),
      ),
    );

    tasks.removeWhere((e) => e.id == id);

    final taskJson = tasks.map((e) => e.toJson()).toList();

    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(taskJson);

    prefs.setString('tasks', encoded);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final todoTasks = tasks.where((e) => !e.isDone).toList();
    final completedTasks = tasks.where((e) => e.isDone).toList();

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTransition: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeView(
            tasks: tasks,
            onCheck: checkTask,
            loadTasks: loadTasks,
            removeTask: removeTask,
          ),
          TodoTasks(
            todoTasks: todoTasks,
            onCheck: checkTask,
            removeTask: removeTask,
            loadTasks: loadTasks,
          ),
          CompletedTasks(completedTasks: completedTasks, onCheck: checkTask),
          ProfileView(),
        ],
      ),
    );
  }
}
