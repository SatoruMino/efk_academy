part of 'get_review_cubit.dart';

@immutable
sealed class GetReviewState {}

final class GetReviewInitial extends GetReviewState {}

final class GetReviewInProgress extends GetReviewState {}

final class GetReviewFailure extends GetReviewState {
  final String message;
  GetReviewFailure(this.message);
}

final class GetReviewSuccess extends GetReviewState {
  final List<Review> reviews;
  GetReviewSuccess(this.reviews);
}
