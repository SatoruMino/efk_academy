part of 'get_new_cubit.dart';

@immutable
sealed class GetNewState {}

final class GetNewInitial extends GetNewState {}

final class GetNewInProgress extends GetNewState {}

final class GetNewFailure extends GetNewState {
  final String message;
  GetNewFailure(this.message);
}

final class GetNewSuccess extends GetNewState {
  final List<New> news;
  GetNewSuccess(this.news);
}
