import 'package:efk_academy/common/theme_notifier/theme_notifier.dart';
import 'package:efk_academy/core/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangeThemePage extends StatelessWidget {
  const ChangeThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ThemeNotifier>();
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          RadioListTile(
            value: ThemeMode.light,
            groupValue: notifier.themeMode,
            title: Text(
              'ផ្ទៃស',
            ),
            onChanged: (value) => notifier.onChanged(value!),
          ),
          RadioListTile(
            value: ThemeMode.dark,
            groupValue: notifier.themeMode,
            title: Text(
              'ផ្ទៃខ្មៅ',
            ),
            onChanged: (value) => notifier.onChanged(value!),
          ),
          RadioListTile(
            value: ThemeMode.system,
            groupValue: notifier.themeMode,
            title: Text(
              'ស្វ័យប្រវត្តិ',
            ),
            onChanged: (value) => notifier.onChanged(value!),
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
      centerTitle: true,
      title: Text(
        'ផ្ទៃពណ៌នៃប្រព័ន្ធ',
        style: labelStyle.copyWith(
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
