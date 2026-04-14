import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/Features/profile/views/user_details_view.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'البيانات الشخصية',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),

        const SizedBox(height: 8),

        /// ================= USER DETAILS =================
        _buildListTile(
          context,
          title: 'معلومات المستخدم',
          onTap: () async {
            final main = context.read<MainController>();

            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: main,
                  child: const UserDetailsView(),
                ),
              ),
            );

            if (result == true) {}
          },
          leading: SvgPicture.asset(AssetsManager.imagesIconsProfileIcon),
        ),

        Consumer<ThemeManager>(
          builder: (context, theme, _) {
            final controller = context.read<ThemeManager>();

            return _buildListTile(
              context,
              title: 'الوضع المظلم',
              leading: SvgPicture.asset(AssetsManager.imagesIconsDarkModeIcon),
              haveSwitch: true,
              switchValue: theme.themeMode == ThemeMode.dark,
              onChangedSwitch: (value) =>
                  controller.setTheme(value ? ThemeMode.dark : ThemeMode.light),
            );
          },
        ),

        _buildListTile(
          context,
          title: 'تسجيل الخروج',
          onTap: () async {
            await PreferenceManager.removeKey(StorageKey.welcome);
            await PreferenceManager.removeKey(StorageKey.username);
            await PreferenceManager.removeKey(StorageKey.motivationQuote);

            if (!context.mounted) return;

            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.welcomeView,
              (route) => false,
            );
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
