import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/sign_out/cubit/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOutPage extends StatelessWidget {
  const SignOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inProgress = context
        .select((SignOutCubit cubit) => cubit.state is SignOutInProgress);
    return Scaffold(
      body: BlocListener<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is SignOutFailure) {
            Toast.error(state.message);
          }
          if (state is SignOutSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ចាកចេញ',
                  style: labelStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'តើអ្នកប្រាកដទេថាអ្នកនឹងចាកចេញពីគណនីមួយនេះ?',
                  style: labelStyle.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'បោះបង់',
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: CustomButton(
                        inProgress: inProgress,
                        text: 'យល់ព្រម',
                        onTap: () {
                          context.read<SignOutCubit>().signOut();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
