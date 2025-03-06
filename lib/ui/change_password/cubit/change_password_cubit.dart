import 'package:efk_academy/domain/usecases/user/change_password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ChangePassword changePassword,
  })  : _changePassword = changePassword,
        super(ChangePasswordState());

  final ChangePassword _changePassword;

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
      ),
    );
  }

  void newPasswordChanged(String value) {
    emit(
      state.copyWith(
        newPassword: value,
      ),
    );
  }

  Future<void> changePassword() async {
    emit(
      state.copyWith(
        status: ChangePasswordStatus.inProgress,
      ),
    );

    final res = await _changePassword(
      ChangePasswordParams(
        state.password,
        state.newPassword,
      ),
    );

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: ChangePasswordStatus.failure,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: ChangePasswordStatus.success,
        ),
      ),
    );
  }
}
