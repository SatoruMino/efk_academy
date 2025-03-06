part of 'sign_out_cubit.dart';

@immutable
sealed class SignOutState {}

final class SignOutInitial extends SignOutState {}

final class SignOutInProgress extends SignOutState {}

final class SignOutFailure extends SignOutState {
  final String message;
  SignOutFailure(this.message);
}

final class SignOutSuccess extends SignOutState {}
