part of 'get_review_cubit.dart';

enum GetReviewStatus { initial, inProgress, failure, success }

final class GetReviewState extends Equatable {
  const GetReviewState({
    this.reviews = const [],
    this.errorMessage = '',
    this.status = GetReviewStatus.initial,
  });

  final List<Review> reviews;
  final String errorMessage;
  final GetReviewStatus status;

  @override
  List<Object?> get props => [reviews, errorMessage, status];

  GetReviewState copyWith({
    List<Review>? reviews,
    String? errorMessage,
    GetReviewStatus? status,
  }) {
    return GetReviewState(
      reviews: reviews ?? this.reviews,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
