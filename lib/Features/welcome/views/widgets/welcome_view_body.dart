import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/welcome/controller/welcome_controller.dart';
import 'package:todo_app/Features/welcome/views/widgets/get_started_button.dart';
import 'package:todo_app/Features/welcome/views/widgets/main_welcome_section.dart';
import 'package:todo_app/core/utils/app_size.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WelcomeController>();

    return Consumer<WelcomeController>(
      builder: (context, value, _) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: value.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSize.h(16)),
                  const MainWelcomeSection(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.w(16),
            vertical: AppSize.h(24),
          ),
          child: GetStartedButton(
            isButtonActive: value.isButtonActive,
            nameController: value.nameController,
            onTapGetStartedBtn: () async{
              await controller.saveUserData(context);
            },
          ),
        ),
      ),
    );
  }
}