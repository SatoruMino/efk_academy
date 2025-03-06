import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/sign_in/cubits/sign_in_cubit.dart';
import 'package:efk_academy/ui/sign_up/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignInCubit>(),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obsecureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inProgress =
        context.select((SignInCubit cubit) => cubit.state is SignInInProgress);
    return Scaffold(
      appBar: appBar(context),
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            Toast(context).error(state.message);
          }
          if (state is SignInSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  header(),
                  const SizedBox(height: 12.0),
                  inputFields(),
                  const SizedBox(height: 12.0),
                  submitButton(inProgress),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
      extendBodyBehindAppBar: true,
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      color: Theme.of(context).shadowColor,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr('sign_in_page.not_yet_having_an_account'),
            style: labelStyle,
          ),
          const SizedBox(width: 4.0),
          GestureDetector(
            onTap: () {
              AppNavigator.pushReplacement(const SignUpPage());
            },
            child: Text(
              tr('sign_in_page.create_account'),
              style: labelStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton(bool inProgress) {
    return CustomButton(
      text: tr('sign_in_page.sign_in'),
      inProgress: inProgress,
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<SignInCubit>().signInWithPassword(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              );
        }
      },
    );
  }

  Widget inputFields() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'someone@example.com',
            labelText: tr('sign_in_page.email'),
            prefixIcon: const Icon(MingCute.user_1_fill),
          ),
          validator: (value) => Validation.validateEmail(value!),
        ),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: _passwordController,
          obscureText: _obsecureText,
          decoration: InputDecoration(
            hintText: 'ពាក្យសម្ងាត់ ៦ ខ្ទង់',
            labelText: tr('sign_in_page.password'),
            prefixIcon: const Icon(Iconsax.lock_1_bold),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              icon: Icon(
                _obsecureText ? Iconsax.eye_bold : Iconsax.eye_slash_bold,
              ),
            ),
          ),
          validator: (value) => Validation.validatePassword(value!),
        ),
      ],
    );
  }

  Widget header() {
    return Column(
      children: [
        Image.asset(
          height: 175.h,
          'assets/images/sign_in_illustrator.png',
        ),
        const SizedBox(height: 12.0),
        Text(
          tr('sign_in_page.welcome_to'),
          style: labelStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
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

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
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
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/efk.png',
          ),
        ),
      ],
    );
  }
}
