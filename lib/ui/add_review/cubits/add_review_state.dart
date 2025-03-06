part of 'add_review_cubit.dart';

enum AddReviewStatus {
  initial,
  inProgress,
  failure,
  success,
}

final class AddReviewState extends Equatable {
  const AddReviewState({
    this.message = '',
    this.errorMessage = '',
    this.status = AddReviewStatus.initial,
  });

  final String message;
  final String errorMessage;
  final AddReviewStatus status;

  @override
  List<Object?> get props => [message, errorMessage, status];

  AddReviewState copyWith({
    String? message,
    String? errorMessage,
    AddReviewStatus? status,
  }) {
    return AddReviewState(
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
