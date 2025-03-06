import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddReview implements Usecase<Review, AddReviewParams> {
  final ReviewRepository reviewRepository;

  const AddReview(this.reviewRepository);

  @override
  Future<Either<Failure, Review>> call(AddReviewParams param) async {
    return await reviewRepository.addReview(param.courseId, param.message);
  }
}

class AddReviewParams {
  const AddReviewParams(this.courseId, this.message);

  final String courseId;
  final String message;
}
