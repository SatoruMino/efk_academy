import 'package:efk_academy/core/models/email.dart';
import 'package:efk_academy/domain/usecases/auth/forget_password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({
    required ForgetPassword forgetPassword,
  })  : _forgetPassword = forgetPassword,
        super(const ForgetPasswordState());

  final ForgetPassword _forgetPassword;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email]),
    ));
  }

  Future<void> forgetPassword() async {
    if (!state.isValid) return;

    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    final res = await _forgetPassword(state.email.value);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (_) => emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      )),
    );
  }
}
