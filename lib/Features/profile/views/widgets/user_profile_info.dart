import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/datasource/preference_manager.dart';
import 'package:todo_app/core/datasource/storage_key.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/theme/app_fonts.dart';

class UserProfileInfo extends StatefulWidget {
  const UserProfileInfo({super.key});

  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  late String userName = 'Guest';
  late String motivationQuote = 'حارب لأجل حلمك';

  Future<void> fetchUserNameAndMotivationQuote() async {
    userName =
        PreferenceManager.getData<String?>(StorageKey.username) ?? userName;
    motivationQuote =
        PreferenceManager.getData<String?>(StorageKey.motivationQuote) ??
        motivationQuote;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUserNameAndMotivationQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (BuildContext context, MainController value, Widget? child) {
        return Column(
          children: [
            Text(
              value.userName.capitalizeEachWord,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.motivationQuote.capitalizeEachWord,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: 16,
                fontFamily: AppFonts.cairoFontFamily,
                color: Color(0xFFC6C6C6),
              ),
            ),
          ],
        );
      },
    );
  }
}
