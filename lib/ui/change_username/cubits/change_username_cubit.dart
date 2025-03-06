import 'package:efk_academy/common/user_cubit/user_cubit.dart';
import 'package:efk_academy/domain/usecases/user/change_username.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  String get _username => _userCubit.state.user!.username;
  DateTime? get _updatedAt => _userCubit.state.user!.updatedAt;

  void usernameChanged(String value) {
    emit(state.copyWith(
      username: value,
      isValid: value != '' && value != _username,
    ));
  }

  Future<void> changeUsername() async {
    emit(
      state.copyWith(
        status: ChangeUsernameStatus.inProgress,
      ),
    );

    final differences =
        DateTime.now().difference(_updatedAt ?? DateTime.now()).inDays;

    if (differences < 90) {
      emit(state.copyWith(
        errorMessage: 'អ្នកមិនទាន់មានលទ្ធភាពក្នុងការផ្លាស់ប្តូរឈ្មោះនៅឡើយទេ!',
        status: ChangeUsernameStatus.failure,
      ));
      return;
    }

    final res = await _changeUsername(state.username);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: ChangeUsernameStatus.failure,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: ChangeUsernameStatus.success,
        ),
      ),
    );
  }
}
