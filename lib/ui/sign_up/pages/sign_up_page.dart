import 'package:efk_academy/core/components/components.dart';
import 'package:efk_academy/core/style/style.dart';
import 'package:efk_academy/core/utils/utils.dart';
import 'package:efk_academy/service_locator.dart';
import 'package:efk_academy/ui/sign_in/pages/sign_in_page.dart';
import 'package:efk_academy/ui/sign_up/cubits/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            Toast(context).error(state.message);
          }
          if (state is SignUpSuccess) {
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
                  inputField(),
                  const SizedBox(height: 12.0),
                  signUpButton(),
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
            'មានគណនីរួចមែនដែរឬទេ?',
            style: labelStyle,
          ),
          const SizedBox(width: 4.0),
          GestureDetector(
            onTap: () {
              AppNavigator.pushReplacement(const SignInPage());
            },
            child: Text(
              'ចូលគណនី',
              style: labelStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUpButton() {
    return CustomButton(
      text: 'បង្កើតគណនី',
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<SignUpCubit>().signUpWithPassword(
                _usernameController.text.trim(),
                _emailController.text.trim(),
                _passwordController.text.trim(),
              );
        }
      },
    );
  }

  Widget inputField() {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'គោត្តនាម-នាម',
            labelText: 'ឈ្មោះ (Username)',
          ),
          validator: (value) => Validation.validateUsername(value!),
        ),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'អុីម៉ែល (Email)',
          ),
          validator: (value) => Validation.validateEmail(value!),
        ),
        const SizedBox(height: 12.0),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'ពាក្យសម្ងាត់ ៨ ខ្ទង់',
            labelText: 'ពាក្យសម្ងាត់ (Password)',
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
          'ចុះឈ្មោះឥឡូវនេះដើម្បីចូលរួមជាមួយ',
          style: labelStyle.copyWith(
            fontSize: 16.sp,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'EFK ACADEMY',
          style: labelStyle.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
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
      actions: [
        Text(
          'EFK\nACADEMY',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/efk.png',
          ),
        ),
      ],
    );
  }
}
