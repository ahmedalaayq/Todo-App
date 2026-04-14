import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/welcome/controller/welcome_controller.dart';
import 'package:todo_app/Features/welcome/views/widgets/welcome_view_body.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ChangeNotifierProvider(
        create: (context)=> WelcomeController(),
        child: WelcomeViewBody())),
    );
  }
}