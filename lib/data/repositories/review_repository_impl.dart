import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/review_remote_data_source.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:fpdart/fpdart.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  const ReviewRepositoryImpl(this.reviewRemoteDataSource);

  @override
  Future<Either<Failure, List<Review>>> getReview(String courseId) async {
    try {
      final reviews = await reviewRemoteDataSource.getReview(courseId);

      return right(reviews);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Review>> addReview(
    String courseId,
    String message,
  ) async {
    try {
      final review = await reviewRemoteDataSource.addReview(courseId, message);

      return right(review);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
