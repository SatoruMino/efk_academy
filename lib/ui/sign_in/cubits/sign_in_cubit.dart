import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/usecases/auth/sign_in_with_password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required SignInWithPassword signInWithPassword,
    required UserCubit userCubit,
  })  : _signInWithPassword = signInWithPassword,
        _userCubit = userCubit,
        super(const SignInState());

  final SignInWithPassword _signInWithPassword;
  final UserCubit _userCubit;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [state.email, password],
        ),
      ),
    );
  }

  Future<void> signInWithPassword() async {
    if (!state.isValid) return;

    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    final res = await _signInWithPassword(
      SignInWithPasswordParams(
        state.email.value,
        state.password.value,
      ),
    );

    res.fold(
      (l) => emit(state.copyWith(
        errorMessage: l.message,
        status: FormzSubmissionStatus.failure,
      )),
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
