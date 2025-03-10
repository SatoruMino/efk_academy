part of 'sign_up_cubit.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.errorMessage = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Username username;
  final Email email;
  final Password password;
  final bool isValid;
  final String errorMessage;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props =>
      [username, email, password, isValid, errorMessage, status];

  SignUpState copyWith({
    Username? username,
    Email? email,
    Password? password,
    bool? isValid,
    String? errorMessage,
    FormzSubmissionStatus? status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
