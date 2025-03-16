part of 'sign_in_cubit.dart';

final class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.obsecureText = false,
    this.isValid = false,
    this.errorMessage = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final Password password;
  final bool obsecureText;
  final bool isValid;
  final String errorMessage;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props =>
      [email, password, obsecureText, isValid, errorMessage, status];

  SignInState copyWith({
    Email? email,
    Password? password,
    bool? obsecureText,
    String? errorMessage,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      obsecureText: obsecureText ?? this.obsecureText,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
