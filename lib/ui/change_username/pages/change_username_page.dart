import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangeUsernameCubit>(),
      child: Scaffold(
        appBar: appBar(context),
        body: BlocListener<ChangeUsernameCubit, ChangeUsernameState>(
          listener: (context, state) {
            if (state.status == ChangeUsernameStatus.failure) {
              AppToast.error(state.errorMessage);
            }
          },
          listenWhen: (previous, current) => current.status != previous.status,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              children: [
                ChangeUsernameInputField(),
                const SizedBox(height: 8.0),
                note(context),
                const SizedBox(height: 8.0),
                ChangeUsernameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget note(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: labelStyle.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'ចំណាំៈ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(
              width: 4.0,
            ),
          ),
          TextSpan(
            text:
                'អ្នកអាចមានលទ្ធភាពក្នុងការផ្លាស់ប្តូរឈ្មោះប្រើប្រាស់ជារៀងរាល់ ៩០ ថ្ងៃម្តង!',
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.close_outlined,
        ),
      ),
    );
  }
}

class ChangeUsernameInputField extends StatelessWidget {
  const ChangeUsernameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    var username =
        context.select((UserCubit cubit) => cubit.state.user!.username);
    return TextField(
      controller: TextEditingController(text: username),
      decoration: InputDecoration(
        labelText: 'ឈ្មោះប្រើប្រាស់ (Username)',
        prefixIcon: const Icon(MingCute.user_2_fill),
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
    final enabled =
        context.select((ChangeUsernameCubit cubit) => cubit.state.isValid);
    final inProgress = context.select((ChangeUsernameCubit cubit) =>
        cubit.state.status == ChangeUsernameStatus.inProgress);
    return CustomButton(
      text: 'ប្តូរឈ្មោះ',
      inProgress: inProgress,
      enabled: enabled,
      onTap: () {
        context.read<ChangeUsernameCubit>().changeUsername();
      },
    );
  }
}
