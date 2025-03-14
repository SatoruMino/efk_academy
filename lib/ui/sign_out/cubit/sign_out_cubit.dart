import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/usecases/auth/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit({
    required SignOut signOut,
  })  : _signOut = signOut,
        super(SignOutInitial());

  final SignOut _signOut;

  Future<void> signOut() async {
    emit(SignOutInProgress());

    final res = await _signOut(NoParam());

    res.fold(
      (l) => emit(
        SignOutFailure(
          l.message,
        ),
      ),
      (user) {
        emit(SignOutSuccess());
      },
    );
  }
}
