import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
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
        ),
        body: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              AppToast.error(state.errorMessage);
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
                  Header(),
                  const SizedBox(height: 12.0),
                  EmailInput(),
                  const SizedBox(height: 12.0),
                  PasswordInput(),
                  const SizedBox(height: 12.0),
                  SubmitButton(),
                ],
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Column(
      children: [
        Image.asset(
          height: 175.h,
          'assets/images/sign_in_illustrator.png',
        ),
        Text(
          tr('sign_in_page.welcome_to'),
          style: labelStyle.copyWith(
            fontSize: 16.sp,
          ),
        ),
        Text(
          'EFK ACADEMY',
          style: TextStyle(
            color: color,
            fontSize: 18.sp,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((SignInCubit cubit) => cubit.state.email.displayError);
    return TextField(
      onChanged: (value) => context.read<SignInCubit>().emailChanged(value),
      decoration: InputDecoration(
        hintText: 'someone@example.com',
        labelText: tr('sign_in_page.email'),
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

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context
        .select((SignInCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (value) => context.read<SignInCubit>().passwordChanged(value),
      decoration: InputDecoration(
        hintText: tr('sign_in_page.password_hint'),
        labelText: tr('sign_in_page.password'),
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

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled = context.select((SignInCubit cubit) => cubit.state.isValid);
    final inProgress =
        context.select((SignInCubit cubit) => cubit.state.status.isInProgress);
    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: tr('sign_in_page.sign_in'),
      onTap: () => context.read<SignInCubit>().signInWithPassword(),
    );
  }
}
