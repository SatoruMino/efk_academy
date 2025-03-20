import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnedPage extends StatelessWidget {
  const OwnedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'owned'.tr(),
          style: labelStyle.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
