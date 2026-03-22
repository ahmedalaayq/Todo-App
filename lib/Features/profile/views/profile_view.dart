import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/profile/views/widgets/profile_avatar.dart';
import 'package:todo_app/Features/profile/views/widgets/profile_section.dart';
import 'package:todo_app/core/utils/app_size.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username') ?? "";
    motivationQuote = prefs.getString('motivationQuote') ?? "";
    setState(() {});
  }

  String userName = '', motivationQuote = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

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
            const SizedBox(height: 24),
            // todo: Profile Section
            ProfileSection(
              userName: userName,
              motivationQuote: motivationQuote,
            ),
          ],
        ),
      ),
    );
  }
}
