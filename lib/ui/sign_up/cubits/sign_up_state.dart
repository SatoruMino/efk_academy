part of 'sign_up_cubit.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.obsecureText = true,
    this.isValid = false,
    this.message = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Username username;
  final Email email;
  final Password password;
  final bool obsecureText;
  final bool isValid;
  final String message;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props =>
      [username, email, password, obsecureText, isValid, message, status];

  SignUpState copyWith({
    Username? username,
    Email? email,
    Password? password,
    bool? obsecureText,
    bool? isValid,
    String? message,
    FormzSubmissionStatus? status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      obsecureText: obsecureText ?? this.obsecureText,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
