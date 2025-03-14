import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/common/user_cubit.dart';
import 'package:efk_academy/core/components/custom_button.dart';
import 'package:efk_academy/core/utils/validation.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:icons_plus/icons_plus.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.close_outlined,
          ),
        ),
      ),
      body: Column(
        children: [
          ChangeUsernameInput(),
          const SizedBox(height: 12),
          ChangeUsernameButton(),
        ],
      ),
    );
  }
}

class ChangeUsernameInput extends StatelessWidget {
  const ChangeUsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final username =
        context.select((UserCubit cubit) => cubit.state.user.username);
    final displayError = context.select(
        (ChangeUsernameCubit cubit) => cubit.state.username.displayError);
    return TextFormField(
      initialValue: username,
      decoration: InputDecoration(
        labelText: 'username'.tr(),
        prefixIcon: Icon(Iconsax.user_bold),
        errorText: Validation.usernameError(displayError),
      ),
      onChanged: (value) =>
          context.read<ChangeUsernameCubit>().usernameChanged(value),
    );
  }
}

class ChangeUsernameButton extends StatelessWidget {
  const ChangeUsernameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'change_username'.tr(),
      onTap: () => context.read<ChangeUsernameCubit>().changeUsername(),
    );
  }
}
