part of 'forget_password_cubit.dart';

final class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.email = const Email.pure(),
    this.isValid = false,
    this.errorMessage = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final bool isValid;
  final String errorMessage;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [email, isValid, errorMessage, status];

  ForgetPasswordState copyWith({
    Email? email,
    bool? isValid,
    String? errorMessage,
    FormzSubmissionStatus? status,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
