import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/core/helpers/navigator.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/sign_up/cubits/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
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
                color: Theme.of(context).primaryColor,
                fontFamily: 'Ubuntu',
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
        body: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              Toast.error(state.errorMessage);
            }
            if (state.status.isSuccess) {
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
                  SignUpHeader(),
                  const SizedBox(height: 12),
                  SignUpUsernameInput(),
                  const SizedBox(height: 12),
                  SignUpEmailInput(),
                  const SizedBox(height: 12),
                  SignUpPasswordInput(),
                  const SizedBox(height: 12),
                  SignUpButton(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('authentication.sign_up_page.already_having_an_account'),
                style: labelStyle,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  NavigatorHelper.push(AppRoute.signIn);
                },
                child: Text(
                  tr('authentication.sign_up_page.sign_in'),
                  style: labelStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 175.h,
          'assets/images/sign_in_illustrator.png',
        ),
        Text(
          tr('authentication.sign_up_page.join_with_us'),
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

class SignUpUsernameInput extends StatelessWidget {
  const SignUpUsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((SignUpCubit cubit) => cubit.state.username.displayError);
    return TextField(
      onChanged: (value) {
        context.read<SignUpCubit>().usernameChanged(value);
      },
      decoration: InputDecoration(
        hintText: tr('authentication.sign_up_page.username_hint'),
        labelText: tr('authentication.username'),
        prefixIcon: const Icon(Iconsax.user_bold),
        errorText: displayError != null
            ? tr('validation.username_is_not_validated')
            : null,
      ),
    );
  }
}

class SignUpEmailInput extends StatelessWidget {
  const SignUpEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((SignUpCubit cubit) => cubit.state.email.displayError);
    return TextField(
      onChanged: (value) {
        context.read<SignUpCubit>().emailChanged(value);
      },
      decoration: InputDecoration(
        hintText: 'someone@example.com',
        labelText: tr('authentication.email'),
        prefixIcon: const Icon(MingCute.mail_fill),
        errorText: displayError != null
            ? tr('validation.email_is_not_validated')
            : null,
      ),
    );
  }
}

class SignUpPasswordInput extends StatelessWidget {
  const SignUpPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((SignUpCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (value) {
        context.read<SignUpCubit>().passwordChanged(value);
      },
      decoration: InputDecoration(
        hintText: tr('authentication.sign_up_page.password_hint'),
        labelText: tr('authentication.password'),
        prefixIcon: const Icon(Iconsax.lock_1_bold),
        errorText: displayError != null
            ? tr('validation.password_is_not_validated')
            : null,
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled = context.select((SignUpCubit cubit) => cubit.state.isValid);
    final inProgress =
        context.select((SignUpCubit cubit) => cubit.state.status.isInProgress);
    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: tr('authentication.sign_up_page.create_account'),
      onTap: () {
        context.read<SignUpCubit>().signUpWithPassword();
      },
    );
  }
}
