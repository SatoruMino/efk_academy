part of 'user_cubit.dart';

enum UserStatus {
  initial,
  inProgress,
  failure,
  success,
}

final class UserState extends Equatable {
  const UserState({
    this.user,
    this.errorMessage = '',
    this.status = UserStatus.initial,
  });

  final User? user;
  final String errorMessage;
  final UserStatus status;

  @override
  List<Object?> get props => [user, errorMessage, status];

  UserState copyWith({
    User? user,
    String? errorMessage,
    UserStatus? status,
  }) {
    return UserState(
      user: user,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
