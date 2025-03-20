import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ChangePassword changePassword,
  })  : _changePassword = changePassword,
        super(const ChangePasswordState());

  final ChangePassword _changePassword;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [password, state.newPassword],
        ),
      ),
    );
  }

  void newPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    emit(
      state.copyWith(
        newPassword: newPassword,
        isValid: Formz.validate(
          [state.password, newPassword],
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    if (!state.isValid) return;

    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    final res = await _changePassword(ChangePasswordParams(
      state.password.value,
      state.newPassword.value,
    ));

    res.fold(
      (l) => emit(
        state.copyWith(
          message: l.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (user) => emit(
        state.copyWith(
          message: 'change_successfully',
          status: FormzSubmissionStatus.success,
        ),
      ),
    );
  }
}
