import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/usecases/auth/sign_up_with_password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required SignUpWithPassword signUpWithPassword,
    required UserCubit userCubit,
  })  : _signUpWithPassword = signUpWithPassword,
        _userCubit = userCubit,
        super(const SignUpState());

  final SignUpWithPassword _signUpWithPassword;
  final UserCubit _userCubit;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate(
          [username, state.email, state.password],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [state.username, email, state.password],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [state.username, state.email, password],
        ),
      ),
    );
  }

  Future<void> signUpWithPassword() async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );

    final res = await _signUpWithPassword(
      SignUpWithPasswordParams(
        state.username.value,
        state.email.value,
        state.password.value,
      ),
    );

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (user) {
        _userCubit.getUser();
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }
}
