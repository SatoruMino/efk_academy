import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/usecases/auth/change_username.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'change_username_state.dart';

class ChangeUsernameCubit extends Cubit<ChangeUsernameState> {
  ChangeUsernameCubit({
    required ChangeUsername changeUsername,
    required String currentUsername,
  })  : _changeUsername = changeUsername,
        _currentUsername = currentUsername,
        super(const ChangeUsernameState());

  final ChangeUsername _changeUsername;
  final String _currentUsername;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      isValid: username.value != _currentUsername && Formz.validate([username]),
    ));
  }

  Future<void> changeUsername() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final res = await _changeUsername(state.username.value);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      ),
    );
  }
}
