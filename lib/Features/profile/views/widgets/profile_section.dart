import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/profile/views/user_details_view.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/theme/dark_theme.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';
import 'package:todo_app/main.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });
  final String userName, motivationQuote;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  bool getAppTheme() {
    return PreferenceManager.getData<bool>('theme') ?? false;
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
          onTap: () async {
            final result = await context.push(
              UserDetailsView(
                userName: widget.userName,
                motivationQuote: widget.motivationQuote,
              ),
            );
            if (result != null && result) {}
          },
          leading: SvgPicture.asset(AssetsManager.imagesIconsProfileIcon),
        ),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeManager.themeNotifier,
          builder: (context, updatedTheme, _) => _buildListTile(
            context,
            title: 'الوضع المظلم',
            leading: SvgPicture.asset(AssetsManager.imagesIconsDarkModeIcon),
            haveSwitch: true,
            switchValue: updatedTheme == .dark,
            onChangedSwitch: (value) =>
                ThemeManager.setTheme(value == true ? .dark : .light),
          ),
        ),
        _buildListTile(
          context,
          title: 'تسجيل الخروج',
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('welcome');
            await prefs.remove('username');
            await prefs.remove('motivationQuote');
            if (!context.mounted) return;
            context.pushNamedAndRemoveUntil(routeName: AppRoutes.welcomeView);
          },
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
          fontSize: AppSize.sp(17),
          fontFamily: AppFonts.cairoFontFamily,
        ),
        trailing: haveSwitch
            ? Switch(value: switchValue, onChanged: onChangedSwitch)
            : Icon(Icons.arrow_forward),
      ),
      Divider(
        height: AppSize.h(8),
        thickness: AppSize.w(1.8),
        color: const Color(0xFF6E6E6E),
      ),
    ],
  );
}
