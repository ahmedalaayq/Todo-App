import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Features/profile/views/widgets/profile_section.dart';
import 'package:todo_app/Features/profile/views/widgets/user_profile_info.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Center(
              child: Text(
                'الملف الشخصي',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: .bold,fontSize: 20.sp),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Stack(
                    clipBehavior: .none,
                    alignment: .bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          AssetsManager.imagesAhmed,
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        child: InkWell(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          overlayColor: .all(Colors.transparent),
                              onTap: () {
                          // todo trigger attach image logic
                          log('trigger attach image logic');
                        },
                          child: Container(
                            padding: .all(8),
                            decoration: BoxDecoration(
                              shape: .circle,
                              color: const Color(0xFF282828),
                            ),
                            child: Icon(Icons.camera_alt_outlined, size: 26.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // todo: user profile info
                  UserProfileInfo(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // todo: Profile Section
            ProfileSection(),
          ],
        ),
      ),
    );
  }
}
