import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/ui/change_username/cubits/change_username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({super.key});

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
      body: BlocListener<ChangeUsernameCubit, ChangeUsernameState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            AppToast.error(state.errorMessage);
          }
          if (state.status.isFailure) {
            AppToast.success('ឈ្មោះរបស់អ្នកត្រូវបានផ្លាស់ប្តូរ!');
          }
        },
        listenWhen: (previous, current) => current.status != previous.status,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Column(
            children: [
              UsernameInputField(),
              const SizedBox(height: 12),
              const UsernameNote(),
              const SizedBox(height: 12),
              UsernameChangeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class UsernameInputField extends StatelessWidget {
  const UsernameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserCubit cubit) => cubit.state.user);
    return TextField(
      controller: TextEditingController(
        text: user!.username,
      ),
      onChanged: (value) {
        context.read<ChangeUsernameCubit>().usernameChanged(value);
      },
      decoration: InputDecoration(
        hintText: 'ឈ្មោះរបស់អ្នក',
        labelText: 'ឈ្មោះប្រើប្រាស់ (Username)',
      ),
    );
  }
}

class UsernameNote extends StatelessWidget {
  const UsernameNote({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'ចំណាំៈ',
            style: labelStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(
              width: 4,
            ),
          ),
          TextSpan(
            text:
                'អ្នកអាចធ្វើការផ្លាស់ប្តូរប្រើប្រាស់ឈ្មោះថ្មីជារៀងរាល់៩០ថ្ងៃម្តង',
            style: descriptionStyle,
          ),
        ],
      ),
    );
  }
}

class UsernameChangeButton extends StatelessWidget {
  const UsernameChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final enabled =
        context.select((ChangeUsernameCubit cubit) => cubit.state.isValid);
    final inProgress = context
        .select((ChangeUsernameCubit cubit) => cubit.state.status.isInProgress);
    return CustomButton(
      enabled: enabled,
      inProgress: inProgress,
      text: 'ប្តូរឈ្មោះ',
      onTap: () {
        context.read<ChangeUsernameCubit>().changeUsername();
      },
    );
  }
}
