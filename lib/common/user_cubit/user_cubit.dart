import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/usecases/user/get_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required GetUser getUser,
  })  : _getUser = getUser,
        super(const UserState());

  final GetUser _getUser;

  void updateUser(User user) {
    emit(state.copyWith(
      user: user,
    ));
  }

  Future<void> getUser() async {
    emit(
      state.copyWith(
        status: UserStatus.inProgress,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    final res = await _getUser(NoParam());

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: UserStatus.failure,
        ),
      ),
      (user) => emit(
        state.copyWith(
          user: user,
          status: UserStatus.success,
        ),
      ),
    );
  }
}
