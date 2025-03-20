import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/cubits/user_cubit/user_cubit.dart';
import 'package:efk_academy/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state == UserState.unknown()) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'do_you_know_that_fish_lives_in_water'.tr(),
                ),
              ],
            ),
          ),
        );
      } else {
        return const HomePage();
      }
    });
  }
}
