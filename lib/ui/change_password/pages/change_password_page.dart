import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/change_password/cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordCubit>(),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inProgress = context.select((ChangePasswordCubit cubit) =>
        cubit.state.status == ChangePasswordStatus.inProgress);
    return Scaffold(
      appBar: appBar(),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == ChangePasswordStatus.failure) {
            AppToast.error(state.errorMessage);
          }
          if (state.status == ChangePasswordStatus.success) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                inputField(),
                const SizedBox(height: 12.0),
                tip(),
                const SizedBox(height: 12.0),
                changePasswordButton(inProgress),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget changePasswordButton(bool inProgress) {
    return CustomButton(
      text: 'ប្រើប្រាស់ពាក្យសម្ងាត់ថ្មី',
      inProgress: inProgress,
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<ChangePasswordCubit>().changePassword();
        }
      },
    );
  }

  Widget tip() {
    return RichText(
      text: TextSpan(
        style: labelStyle.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'គន្លឺះ:',
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
                'ដើម្បីធ្វើការប្រើប្រាស់ពាក្យសម្ងាត់ថ្មីបាន អ្នកគ្រាន់តែវាយពាក្យសម្ងាត់ដើមរបស់អ្នករួចវាយបង្កើតពាក្យសម្ងាត់ថ្មីជាការស្រេច',
          ),
        ],
      ),
    );
  }

  Widget inputField() {
    return Column(
      children: [
        TextFormField(
          controller: _passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: 'ពាក្យសម្ងាត់ (Current Password)',
          ),
          onChanged: (value) =>
              context.read<ChangePasswordCubit>().passwordChanged(value),
          validator: (value) => Validation.validatePassword(value!),
        ),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: _newPasswordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: 'ពាក្យសម្ងាត់ថ្មី (New Password)',
          ),
          onChanged: (value) =>
              context.read<ChangePasswordCubit>().newPasswordChanged(value),
          validator: (value) => Validation.validatePassword(value!),
        ),
      ],
    );
  }

  AppBar appBar() {
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
