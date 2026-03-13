import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/welcome/views/widgets/get_started_button.dart';
import 'package:todo_app/Features/welcome/views/widgets/main_welcome_section.dart';
import 'package:todo_app/Features/welcome/views/widgets/welcome_appbar.dart';
import 'package:todo_app/core/router/app_routes.dart';

class WelcomeViewBody extends StatefulWidget {
  const WelcomeViewBody({super.key});

  @override
  State<WelcomeViewBody> createState() => _WelcomeViewBodyState();
}

class _WelcomeViewBodyState extends State<WelcomeViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
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

  Future<void> _saveUserName() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('welcome', true);
    await pref.setString('username', _nameController.text.trim());
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.homeView);
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
                WelcomeAppbar(),
                const SizedBox(height: 16),
                MainWelcomeSection(controller: _nameController),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: GetStartedButton(
          isButtonActive: _isButtonActive,
          nameController: _nameController,
          onTapGetStartedBtn: _saveUserName,
        ),
      ),
    );
  }
}
