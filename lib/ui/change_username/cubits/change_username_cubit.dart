import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/usecases/user/change_username.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'change_username_state.dart';

class ChangeUsernameCubit extends Cubit<ChangeUsernameState> {
  ChangeUsernameCubit({
    required ChangeUsername changeUsername,
    required UserCubit userCubit,
  })  : _changeUsername = changeUsername,
        _userCubit = userCubit,
        super(ChangeUsernameState());

  final ChangeUsername _changeUsername;
  final UserCubit _userCubit;

  User get _user => _userCubit.state.user!;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: username.value != _user.username && username.isValid,
      ),
    );
  }

  Future<void> changeUsername() async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );

    final res = await _changeUsername(state.username.value);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: FormzSubmissionStatus.failure,
        ),
      ),
      (user) {
        _userCubit.updateUser(user);
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
          ),
        );
      },
    );
  }
}
