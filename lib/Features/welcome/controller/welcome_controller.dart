import 'package:flutter/material.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/views/main_view.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';

class WelcomeController with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  List<Task> tasks = [];

  bool isButtonActive = false;
  bool _initialized = false;

  void init() {
    if (_initialized) return;
    _initialized = true;

    nameController.addListener(_onNameChanged);
  }

  void _onNameChanged() {
    isButtonActive = nameController.text.trim().isNotEmpty;
    notifyListeners();
  }

  Future<void> saveUserData(BuildContext context) async {
    await PreferenceManager.setData<bool?>(StorageKey.welcome, true);

    await PreferenceManager.setData<String?>(
      StorageKey.username,
      nameController.text.trim(),
    );

    notifyListeners();
    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainView()),
    );
  }

  void disposeController() {
    nameController.removeListener(_onNameChanged);
    nameController.dispose();
  }
}
