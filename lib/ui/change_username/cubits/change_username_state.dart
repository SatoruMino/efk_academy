part of 'change_username_cubit.dart';

final class ChangeUsernameState extends Equatable {
  const ChangeUsernameState({
    this.username = const Username.pure(),
    this.isValid = false,
    this.errorMessage = '',
    this.status = FormzSubmissionStatus.initial,
  });

  final Username username;
  final bool isValid;
  final String errorMessage;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [username, isValid, errorMessage, status];

  ChangeUsernameState copyWith({
    Username? username,
    bool? isValid,
    String? errorMessage,
    FormzSubmissionStatus? status,
  }) {
    return ChangeUsernameState(
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
