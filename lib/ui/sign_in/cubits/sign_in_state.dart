part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInInProgress extends SignInState {}

final class SignInFailure extends SignInState {
  final String message;
  SignInFailure(this.message);
}

final class SignInSuccess extends SignInState {}
