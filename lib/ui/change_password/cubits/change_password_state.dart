part of 'change_password_cubit.dart';

final class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.password = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.isValid = false,
    this.message = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Password password;
  final Password newPassword;
  final bool isValid;
  final String message;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [password, newPassword, isValid, message, status];

  ChangePasswordState copyWith({
    Password? password,
    Password? newPassword,
    bool? isValid,
    String? message,
    FormzSubmissionStatus? status,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
