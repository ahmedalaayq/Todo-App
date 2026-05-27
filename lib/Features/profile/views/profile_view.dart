import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/Features/profile/views/widgets/profile_avatar.dart';
import 'package:todo_app/Features/profile/views/widgets/profile_section.dart';
import 'package:todo_app/Features/profile/views/widgets/user_profile_info.dart';
import 'package:todo_app/core/utils/app_size.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.w(18.0)),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Center(
              child: Text(
                'الملف الشخصي',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                  fontSize: AppSize.sp(20),
                ),
              ),
            ),
            //todo: Profile Avatar
            ProfileAvatar(),
            const SizedBox(height: 16),
            Center(child: UserProfileInfo()),
            // todo: Profile Section
            Consumer<MainController>(
              builder: (context, value, child) {
                return ProfileSection(
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
