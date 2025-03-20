import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/change_password/cubits/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentPasswordInput(),
              const SizedBox(height: 12),
              NewPasswordInput(),
              const SizedBox(height: 12),
              ChangePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentPasswordInput extends StatelessWidget {
  const CurrentPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
        (ChangePasswordCubit cubit) => cubit.state.password.displayError);

    return TextField(
      onChanged: (value) =>
          context.read<ChangePasswordCubit>().passwordChanged(value),
      decoration: InputDecoration(
        hintText: 'enter_your_password'.tr(),
        labelText: 'password'.tr(),
        errorText: Validation.passwordError(displayError),
      ),
    );
  }
}

class NewPasswordInput extends StatelessWidget {
  const NewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
        (ChangePasswordCubit cubit) => cubit.state.newPassword.displayError);

    return TextField(
      onChanged: (value) =>
          context.read<ChangePasswordCubit>().newPasswordChanged(value),
      decoration: InputDecoration(
        hintText: 'create_new_password'.tr(),
        labelText: 'new_password'.tr(),
        errorText: Validation.passwordError(displayError),
      ),
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled =
        context.select((ChangePasswordCubit cubit) => cubit.state.isValid);
    final inProgress = context
        .select((ChangePasswordCubit cubit) => cubit.state.status.isInProgress);

    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: 'change_password'.tr(),
      style: CustomButtonStyle.primary(context),
      onTap: () {
        context.read<ChangePasswordCubit>().changePassword();
      },
    );
  }
}
