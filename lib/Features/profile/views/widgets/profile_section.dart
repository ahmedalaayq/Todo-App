import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/Features/profile/views/user_details_view.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/theme/app_fonts.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  bool themeSwitcher = false;

  void onThemeSwitch(bool value) {
    setState(() {
      themeSwitcher = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'البيانات الشخصية',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: .w500,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
        const SizedBox(height: 8),
        _buildListTile(
          context,
          title: 'معلومات المستخدم',
          onTap: () {
            context.push(UserDetailsView());
          },
          leading: SvgPicture.asset(AssetsManager.imagesIconsProfileIcon),
        ),
        _buildListTile(
          context,
          title: 'الوضع المظلم',
          leading: SvgPicture.asset(AssetsManager.imagesIconsDarkModeIcon),
          haveSwitch: true,
          switchValue: themeSwitcher,
          onChangedSwitch: onThemeSwitch,
        ),
        _buildListTile(
          context,
          title: 'تسجيل الخروج',
          onTap: () {},
          leading: SvgPicture.asset(AssetsManager.imagesIconsLogoutIcon),
        ),
      ],
    );
  }
}

Widget _buildListTile(
  BuildContext context, {
  required String title,
  bool haveSwitch = false,
  bool switchValue = true,
  required SvgPicture leading,
  Function(bool)? onChangedSwitch,
  VoidCallback? onTap,
}) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        contentPadding: .zero,
        leading: leading,
        title: Text(title.capitalizeEachWord),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: .bold,
          fontSize: 17.sp,
          fontFamily: AppFonts.cairoFontFamily,
        ),
        trailing: haveSwitch
            ? Switch(value: switchValue, onChanged: onChangedSwitch)
            : Icon(Icons.arrow_forward),
      ),
      Divider(height: 8.h, thickness: 1.8.w, color: const Color(0xFF6E6E6E)),
    ],
  );
}
