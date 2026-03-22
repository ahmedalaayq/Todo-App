import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/Features/profile/views/widgets/user_profile_info.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Stack(
                    clipBehavior: .none,
                    alignment: .bottomRight,
                    children: [
                      CircleAvatar(
                        radius: AppSize.r(50),
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AssetsManager.imagesAhmed),
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
                              color: Theme.of(context).colorScheme.primaryContainer,
                            ),
                            child: Icon(Icons.camera_alt_outlined, size: AppSize.sp(26)),
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
            );
  }
}