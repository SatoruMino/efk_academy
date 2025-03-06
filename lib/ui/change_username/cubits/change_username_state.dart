part of 'change_username_cubit.dart';

enum ChangeUsernameStatus { initial, inProgress, failure, success }

final class ChangeUsernameState extends Equatable {
  const ChangeUsernameState({
    this.username = '',
    this.errorMessage = '',
    this.isValid = false,
    this.status = ChangeUsernameStatus.initial,
  });

  final String username;
  final bool isValid;
  final String errorMessage;
  final ChangeUsernameStatus status;

  @override
  List<Object?> get props => [username, isValid, errorMessage, status];

  ChangeUsernameState copyWith({
    String? username,
    bool? isValid,
    String? errorMessage,
    ChangeUsernameStatus? status,
  }) {
    return ChangeUsernameState(
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
