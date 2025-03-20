import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/widgets/efk_logo.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/sign_in/cubits/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          EfkLogo(),
        ],
      ),
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            Toast.error(state.message);
          }

          if (state.status.isSuccess) {
            Toast.success(state.message);
            Navigator.of(context).pop();
          }
        },
        listenWhen: (previous, current) => current.status != previous.status,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInHeader(),
                const SizedBox(height: 12),
                SignInEmailInput(),
                const SizedBox(height: 12),
                SignInPasswordInput(),
                const SizedBox(height: 12),
                SignInForgetPassword(),
                const SizedBox(height: 12),
                SignInButton(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => NavigatorHelper.pushReplacement(AppRoute.signUp),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12.sp,
                fontFamily: 'Kantumruy',
              ),
              children: [
                TextSpan(
                  text: 'not_yet_having_an_account'.tr(),
                ),
                const WidgetSpan(child: SizedBox(width: 4)),
                TextSpan(
                  text: 'create_account'.tr(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 175.h,
          'assets/images/sign_in_illustrator.png',
          fit: BoxFit.cover,
        ),
        Text(
          'welcome_to'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'EFK ACADEMY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SignInEmailInput extends StatelessWidget {
  const SignInEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((SignInCubit cubit) => cubit.state.email.displayError);
    return TextField(
      onChanged: (value) => context.read<SignInCubit>().emailChanged(value),
      decoration: InputDecoration(
        hintText: 'someone@example.com',
        labelText: 'email'.tr(),
        prefixIcon: const Icon(Iconsax.user_bold),
        errorText: Validation.emailError(displayError),
      ),
    );
  }
}

class SignInPasswordInput extends StatelessWidget {
  const SignInPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final obsecureText =
        context.select((SignInCubit cubit) => cubit.state.obsecureText);
    final displayError = context
        .select((SignInCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (value) => context.read<SignInCubit>().passwordChanged(value),
      obscureText: obsecureText,
      decoration: InputDecoration(
        hintText: 'password_hint'.tr(),
        labelText: 'password'.tr(),
        prefixIcon: const Icon(Iconsax.lock_1_bold),
        suffixIcon: IconButton(
          onPressed: () => context.read<SignInCubit>().obsecureTextChanged(),
          icon: Icon(
            obsecureText ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
          ),
        ),
        errorText: Validation.passwordError(displayError),
      ),
    );
  }
}

class SignInForgetPassword extends StatelessWidget {
  const SignInForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorHelper.push(AppRoute.forgetPassword),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'forget_password'.tr(),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled = context.select((SignInCubit cubit) => cubit.state.isValid);
    final inProgress =
        context.select((SignInCubit cubit) => cubit.state.status.isInProgress);
    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: 'sign_in'.tr(),
      style: CustomButtonStyle.primary(context),
      onTap: () => context.read<SignInCubit>().signInWithPassword(),
    );
  }
}
