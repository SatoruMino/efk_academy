import 'package:efk_academy/domain/usecases/review/add_review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewCubit({
    required AddReview addReview,
  })  : _addReview = addReview,
        super(const AddReviewState());

  final AddReview _addReview;

  void messageChanged(String value) {
    emit(
      state.copyWith(
        message: value,
      ),
    );
  }

  Future<void> addReview(String courseId) async {
    emit(
      state.copyWith(
        status: AddReviewStatus.inProgress,
      ),
    );

    final res = await _addReview(AddReviewParams(courseId, state.message));

    res.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          status: AddReviewStatus.failure,
        ),
      ),
      (review) => emit(
        state.copyWith(
          status: AddReviewStatus.success,
        ),
      ),
    );
  }
}
