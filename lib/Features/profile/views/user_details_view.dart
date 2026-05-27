import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Features/main/controller/main_controller.dart';
import 'package:todo_app/core/extensions/shared_extensions.dart';
import 'package:todo_app/core/shared/shared_text_form_field.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  late TextEditingController _userNameController;
  late TextEditingController _motivationQuoteController;

  @override
  void initState() {
    super.initState();

    final main = context.read<MainController>();

    _userNameController = TextEditingController(
      text: main.userName.capitalizeEachWord,
    );

    _motivationQuoteController = TextEditingController(
      text: main.motivationQuote,
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
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.cairoFontFamily,
              ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.h(24)),

            Text(
              'اسم المستخدم',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.sp(16),
                  ),
            ),

            SizedBox(height: AppSize.h(8)),

            SharedTextFormField(
              hintText: 'Ahmed Alaayq',
              controller: _userNameController,
            ),

            SizedBox(height: AppSize.h(24)),

            Text(
              'العبارة التحفيزية',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.sp(16),
                  ),
            ),

            SizedBox(height: AppSize.h(8)),

            SharedTextFormField(
              maxLines: 5,
              hintText: 'حارب لأجل حلمك',
              controller: _motivationQuoteController,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.save),

          onPressed: () async {
            final main = context.read<MainController>();

            final name = _userNameController.text.trim();
            final quote = _motivationQuoteController.text.trim();

            await main.updateUserData(name, quote);

            if (!context.mounted) return;
            Navigator.pop(context, true);
          },

          label: const Text('حفظ التعديلات'),
        ),
      ),
    );
  }
}