import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/domain/usecases/auth/sign_up_with_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required SignUpWithPassword signUpWithPassword,
    required UserCubit userCubit,
  })  : _signUpWithPassword = signUpWithPassword,
        _userCubit = userCubit,
        super(SignUpInitial());

  final SignUpWithPassword _signUpWithPassword;
  final UserCubit _userCubit;

  Future<void> signUpWithPassword(
      String username, String email, String password) async {
    emit(SignUpInProgress());

    final res = await _signUpWithPassword(SignUpWithPasswordParams(
      username,
      email,
      password,
    ));

    res.fold(
      (l) => emit(
        SignUpFailure(
          l.message,
        ),
      ),
      (user) {
        _userCubit.getUser();
        emit(SignUpSuccess());
      },
    );
  }
}
