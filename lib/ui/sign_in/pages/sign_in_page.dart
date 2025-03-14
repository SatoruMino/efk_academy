import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/core/helpers/navigator.dart';
import 'package:efk_academy/service_locator.dart';
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
    final color = Theme.of(context).primaryColor;
    return BlocProvider(
      create: (_) => sl<SignInCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close_outlined,
            ),
          ),
          actions: [
            Text(
              'EFK\nACADEMY',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/efk.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
        body: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              Toast.error(state.errorMessage);
            }

            if (state.status.isSuccess) {
              Navigator.of(context).pop();
            }
          },
          listenWhen: (previous, current) => previous.status != current.status,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInHeader(),
                  const SizedBox(height: 12.0),
                  SignInEmailInput(),
                  const SizedBox(height: 12.0),
                  SignInPasswordInput(),
                  const SizedBox(height: 12.0),
                  SignInButton(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('authentication.sign_in_page.not_yet_having_an_account'),
                style: labelStyle,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  NavigatorHelper.push(AppRoute.signUp);
                },
                child: Text(
                  tr('authentication.sign_in_page.create_account'),
                  style: labelStyle.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
      ),
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
        ),
        Text(
          tr('authentication.sign_in_page.welcome_to'),
          style: labelStyle.copyWith(
            fontSize: 16.sp,
          ),
        ),
        Text(
          'EFK ACADEMY',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18.sp,
            fontFamily: 'Ubuntu',
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
        labelText: tr('authentication.email'),
        prefixIcon: const Icon(
          Iconsax.user_bold,
        ),
        errorText: displayError != null
            ? tr('validation.email_is_not_validated')
            : null,
      ),
    );
  }
}

class SignInPasswordInput extends StatelessWidget {
  const SignInPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((SignInCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (value) => context.read<SignInCubit>().passwordChanged(value),
      decoration: InputDecoration(
        hintText: tr('authentication.sign_in_page.password_hint'),
        labelText: tr('authentication.password'),
        prefixIcon: const Icon(
          Iconsax.lock_1_bold,
        ),
        errorText: displayError != null
            ? tr('validation.password_is_not_validated')
            : null,
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
      text: tr('authentication.sign_in_page.sign_in'),
      onTap: () => context.read<SignInCubit>().signInWithPassword(),
    );
  }
}
