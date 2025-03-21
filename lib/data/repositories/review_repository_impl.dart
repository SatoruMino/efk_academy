import 'package:fpdart/fpdart.dart';
import 'package:efk_academy/core/error/error.dart';
import 'package:efk_academy/domain/entities/review.dart';
import 'package:efk_academy/data/datasources/review_remote_data_source.dart';
import 'package:efk_academy/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  const ReviewRepositoryImpl(this.reviewRemoteDataSource);

  @override
  Future<Either<Failure, List<Review>>> getReview(String id) async {
    try {
      final reviews = await reviewRemoteDataSource.getReview(id);

      return right(reviews);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
