import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RadioListTile(
            value: const Locale('km', 'KH'),
            groupValue: context.locale,
            title: Text(
              tr('account_page.system.languages.khmer'),
            ),
            onChanged: (value) async => context.setLocale(value!),
          ),
          RadioListTile(
            value: const Locale('en', 'US'),
            groupValue: context.locale,
            title: Text(
              tr('account_page.system.languages.english'),
            ),
            onChanged: (value) async => context.setLocale(value!),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.close_outlined,
        ),
      ),
    );
  }
}
