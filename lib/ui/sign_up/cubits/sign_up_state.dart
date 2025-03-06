part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpInProgress extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String message;
  SignUpFailure(this.message);
}

final class SignUpSuccess extends SignUpState {}
