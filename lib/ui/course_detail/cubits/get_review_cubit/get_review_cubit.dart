import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/usecases/review/get_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_review_state.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit({
    required GetReview getReview,
  })  : _getReview = getReview,
        super(GetReviewInitial());

  final GetReview _getReview;

  Future<void> getReviews(String courseId) async {
    emit(GetReviewInProgress());

    final res = await _getReview(courseId);

    res.fold(
      (l) => emit(
        GetReviewFailure(
          l.message,
        ),
      ),
      (reviews) => emit(
        GetReviewSuccess(
          reviews,
        ),
      ),
    );
  }
}
