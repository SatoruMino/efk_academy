import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/domain/usecases/auth/sign_in_with_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required SignInWithPassword signInWithPassword,
    required UserCubit userCubit,
  })  : _signInWithPassword = signInWithPassword,
        _userCubit = userCubit,
        super(SignInInitial());

  final SignInWithPassword _signInWithPassword;
  final UserCubit _userCubit;

  Future<void> signInWithPassword(String email, String password) async {
    emit(SignInInProgress());

    final res = await _signInWithPassword(
      SignInWithPasswordParams(email, password),
    );

    res.fold(
      (l) => emit(
        SignInFailure(
          l.message,
        ),
      ),
      (user) {
        _userCubit.getUser();
        emit(SignInSuccess());
      },
    );
  }
}
