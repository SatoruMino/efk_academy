import 'dart:async';
import 'package:efk_academy/domain/entities/user.dart';
import 'package:efk_academy/domain/usecases/auth/get_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required GetUser getUser,
  })  : _getUser = getUser,
        super(const UserState.unknown()) {
    _subscription = _getUser.call.listen((user) => userChanged(user));
  }

  final GetUser _getUser;
  late final StreamSubscription _subscription;

  void userChanged(User user) {
    if (user == User.empty) {
      emit(const UserState.unauthenticated());
    } else {
      emit(UserState.authenticated(user));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
