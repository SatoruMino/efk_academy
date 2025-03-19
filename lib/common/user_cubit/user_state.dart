part of 'user_cubit.dart';

enum UserStatus {
  unknown,
  unauthenticated,
  authenticated,
}

final class UserState extends Equatable {
  const UserState._({
    this.user = User.empty,
    this.status = UserStatus.unknown,
  });

  final User user;
  final UserStatus status;

  const UserState.unknown() : this._();

  const UserState.unauthenticated()
      : this._(status: UserStatus.unauthenticated);

  const UserState.authenticated(User user)
      : this._(user: user, status: UserStatus.authenticated);

  @override
  List<Object?> get props => [user, status];
}
