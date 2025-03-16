import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/components/custom_button.dart';
import 'package:efk_academy/core/utils/validation.dart';
import 'package:efk_academy/ui/forget_password/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ForgetPasswordHeader(),
              const SizedBox(height: 12),
              ForgetPasswordInput(),
              const SizedBox(height: 12),
              ForgetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordHeader extends StatelessWidget {
  const ForgetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forget_password'.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'forget_password_hint'.tr(),
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class ForgetPasswordInput extends StatelessWidget {
  const ForgetPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((ForgetPasswordCubit cubit) => cubit.state.email.displayError);
    return TextField(
      onChanged: (value) =>
          context.read<ForgetPasswordCubit>().emailChanged(value),
      decoration: InputDecoration(
        labelText: 'email'.tr(),
        hintText: 'someone@example.com',
        prefixIcon: const Icon(MingCute.mail_send_fill),
        errorText: Validation.emailError(displayError),
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled =
        context.select((ForgetPasswordCubit cubit) => cubit.state.isValid);
    final inProgress = context
        .select((ForgetPasswordCubit cubit) => cubit.state.status.isInProgress);
    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: 'reset_password'.tr(),
      onTap: () => context.read<ForgetPasswordCubit>().forgetPassword(),
    );
  }
}
