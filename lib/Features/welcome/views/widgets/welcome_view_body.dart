import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/home/models/task.dart';
import 'package:todo_app/Features/main/views/main_view.dart';
import 'package:todo_app/Features/welcome/views/widgets/get_started_button.dart';
import 'package:todo_app/Features/welcome/views/widgets/main_welcome_section.dart';
import 'package:todo_app/Features/welcome/views/widgets/welcome_appbar.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/utils/app_size.dart';

class WelcomeViewBody extends StatefulWidget {
  const WelcomeViewBody({super.key});

  @override
  State<WelcomeViewBody> createState() => _WelcomeViewBodyState();
}

class _WelcomeViewBodyState extends State<WelcomeViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  late SharedPreferences _prefs;
  List<Task> tasks = [];

  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
    _nameController.addListener(() {
      setState(() {
        _isButtonActive = _nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchTasks() async {
    _prefs = await SharedPreferences.getInstance();
    final taskJson = _prefs.getString('tasks');
    if (taskJson != null) {
      final decoded = jsonDecode(taskJson) as List<dynamic>;
      tasks = decoded.map((e) => Task.fromJson(e)).toList();
      setState(() {});
    }
  }

  Future<void> _saveUserName() async {
    await _prefs.setBool('welcome', true);
    await _prefs.setString('username', _nameController.text.trim());
    if (!mounted) return;
    context.pushReplacement(MainView(tasks: tasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize.h(16)),

                WelcomeAppbar(),
                MainWelcomeSection(controller: _nameController),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.w(16.0), vertical: AppSize.h(24)),
        child: GetStartedButton(
          isButtonActive: _isButtonActive,
          nameController: _nameController,
          onTapGetStartedBtn: _saveUserName,
        ),
      ),
    );
  }
}
