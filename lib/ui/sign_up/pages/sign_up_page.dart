import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/widgets/efk_logo.dart';
import 'package:efk_academy/core/core.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: const [
          EfkLogo(),
        ],
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
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
      extendBodyBehindAppBar: true,
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
          fit: BoxFit.cover,
        ),
        Text(
          'join-with-us-now'.tr(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          'EFK ACADEMY',
          style: Theme.of(context).textTheme.displayLarge,
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
      onChanged: (value) => context.read<SignUpCubit>().usernameChanged(value),
      decoration: InputDecoration(
        hintText: 'username-hint'.tr(),
        labelText: 'username'.tr(),
        prefixIcon: const Icon(Iconsax.user_bold),
        errorText: Validation.usernameError(displayError),
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
      onChanged: (value) => context.read<SignUpCubit>().emailChanged(value),
      decoration: InputDecoration(
        hintText: 'someone@example.com',
        labelText: 'email'.tr(),
        prefixIcon: const Icon(Icons.email),
        errorText: Validation.emailError(displayError),
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
    final obsecureText =
        context.select((SignUpCubit cubit) => cubit.state.obsecureText);
    return TextField(
      onChanged: (value) => context.read<SignUpCubit>().passwordChanged(value),
      obscureText: obsecureText,
      decoration: InputDecoration(
        hintText: 'password-hint'.tr(),
        labelText: 'password'.tr(),
        prefixIcon: const Icon(Iconsax.lock_1_bold),
        errorText: Validation.passwordError(displayError),
        suffixIcon: IconButton(
          onPressed: () => context.read<SignUpCubit>().obsecureTextChanged(),
          icon: Icon(
            obsecureText ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
          ),
        ),
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
      text: 'create-account'.tr(),
      style: CustomButtonStyle.primary(context),
      onTap: () => context.read<SignUpCubit>().signUpWithPassword(),
    );
  }
}
