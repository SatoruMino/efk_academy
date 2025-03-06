import 'package:efk_academy/core/core.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ReviewRepository {
  Future<Either<Failure, List<Review>>> getReview(String courseId);
  Future<Either<Failure, Review>> addReview(
    String courseId,
    String message,
  );
}
