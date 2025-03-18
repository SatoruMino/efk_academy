import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/data/datasources/review_remote_data_source.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';
import 'package:fpdart/fpdart.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  const ReviewRepositoryImpl(this.reviewRemoteDataSource);

  @override
  Stream<Either<Failure, List<Review>>> getReview(String courseId) {
    return reviewRemoteDataSource
        .getReview(courseId)
        .map((review) => right(review))
      ..handleError((e) => left(Failure(e.toString())));
  }
}
