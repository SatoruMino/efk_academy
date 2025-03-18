import 'dart:async';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/usecases/review/get_review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit({
    required GetReview getReview,
  })  : _getReview = getReview,
        super(const GetReviewState());

  final GetReview _getReview;

  Future<void> getReviews(String id) async {
    emit(state.copyWith(status: GetReviewStatus.inProgress));

    final res = await _getReview(id);

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: GetReviewStatus.failure,
        ),
      ),
      (reviews) => emit(
        state.copyWith(
          reviews: reviews,
          status: GetReviewStatus.success,
        ),
      ),
    );
  }

  void insertReview(Review review) {
    final reviews = state.reviews;
    reviews.add(review);
    emit(state.copyWith(
      reviews: reviews,
    ));
  }
}
