import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username') ?? userName;
    motivationQuote = prefs.getString('motivationQuote') ?? motivationQuote;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchUserNameAndMotivationQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userName.capitalizeEachWord,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: .bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          motivationQuote,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: .bold,
            fontSize: 16,
            fontFamily: AppFonts.cairoFontFamily,
            color: Color(0xFFC6C6C6),
          ),
        ),
      ],
    );
  }
}
