part of 'change_password_cubit.dart';

enum ChangePasswordStatus {
  initial,
  inProgress,
  failure,
  success,
}

final class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.password = '',
    this.newPassword = '',
    this.errorMessage = '',
    this.status = ChangePasswordStatus.initial,
  });

  final String password;
  final String newPassword;
  final String errorMessage;
  final ChangePasswordStatus status;

  @override
  List<Object?> get props => [password, newPassword, errorMessage, status];

  ChangePasswordState copyWith({
    String? password,
    String? newPassword,
    String? errorMessage,
    ChangePasswordStatus? status,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
