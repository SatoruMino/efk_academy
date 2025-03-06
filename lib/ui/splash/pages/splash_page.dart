import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/home_page/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        switch (state.status) {
          case UserStatus.inProgress:
            return loading();
          case UserStatus.failure:
            return failure(state.errorMessage);
          case UserStatus.success:
            return const HomePage();
          default:
            return empty();
        }
      },
    );
  }

  Widget loading() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45.h,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              tr('splash_page.loading'),
              style: labelStyle.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget failure(String message) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }

  Widget empty() {
    return const SizedBox();
  }
}
