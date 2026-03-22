import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });
  final String userName, motivationQuote;

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  late TextEditingController _userNameController;
  late TextEditingController _motivationQuoteController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.userName.capitalizeEachWord);
    _motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'معلومات المستخدم',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: AppSize.sp(20),
            fontWeight: .bold,
            fontFamily: AppFonts.cairoFontFamily,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: AppSize.h(24)),
            Text(
              'اسم المستخدم',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: AppSize.sp(16),
              ),
            ),
            SizedBox(height:AppSize.h( 8)),
            SharedTextFormField(
              hintText: 'Ahmed Alaayq',
              controller: _userNameController,
            ),
            SizedBox(height: AppSize.h(24)),
            Text(
              'العبارة التحفيزية',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: .bold,
                fontSize: AppSize.sp(16),
              ),
            ),
            SizedBox(height:AppSize.h( 8)),
            SharedTextFormField(
              maxLines: 5,
              hintText: 'حارب لأجل حلمك',
              controller: _motivationQuoteController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        curve: Curves.easeIn,
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.h(16),
        ),
        duration: Duration(milliseconds: 250),
        child: ElevatedButton.icon(
          icon: Icon(Icons.save),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('username', _userNameController.text.trim());
            prefs.setString(
              'motivationQuote',
              _motivationQuoteController.text.trim(),
            );
            if (!context.mounted) return;
            Navigator.pop(context, true);
          },
          label: Text('حفظ التعديلات'),
        ),
      ),
    );
  }
}
